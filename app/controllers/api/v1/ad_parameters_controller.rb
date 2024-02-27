class Api::V1::AdParametersController < ApplicationController
  def index
    file_path = params[:file_path]
    unless file_path.present? && File.exist?(file_path)
      render plain: 'Invalid or missing file path', status: :unprocessable_entity
      return
    end

    placements = {}

    xml_data = File.read(file_path)
    xml_doc = Nokogiri::XML(xml_data)

    xml_doc.xpath('//Creatives/Creative').each do |creative_xml|
      creative_id = creative_xml.attr('id')
      price = creative_xml.attr('price').to_f
      currency = creative_xml.attr('currency')

      creative = find_or_initialize_creative(creative_id)
      creative.update(price: price, currency: currency)

      add_creative_to_placements(creative, placements, xml_doc)
    end

    render plain: serialize_to_proto(placements.values.flatten)
  end

  private

  def find_or_initialize_creative(identifier)
    creative = Creative.find_or_initialize_by(identifier: identifier)
    creative.save if creative.new_record?
    creative
  end

  def find_or_initialize_placement(identifier)
    placement = Placement.find_or_initialize_by(identifier: identifier)
    placement.save if placement.new_record?
    placement
  end

  def add_creative_to_placements(creative, placements, xml_doc)
    xml_doc.xpath('//Placements/Placement').each do |placement_xml|
      placement_id = placement_xml.attr('id')
      floor_price = placement_xml.attr('floor').to_f
      currency = placement_xml.attr('currency')

      converted_floor_price = convert_currency(floor_price, currency)

      placement = find_or_initialize_placement(placement_id)
      placement.update(floor: floor_price, currency: currency)

      if creative.currency == 'EUR'
        price_comparison = creative.price
      else
        price_comparison = convert_currency(creative.price, creative.currency)
      end

      if price_comparison >= converted_floor_price
        placements[placement_id] ||= []
        placements[placement_id] << creative unless placements[placement_id].include?(creative)
      else
        placements[placement_id]&.delete(creative)
      end
    end
  end

  def convert_currency(price, currency_from)
    case currency_from
    when 'TYR'
      price / 3.31
    when 'USD'
      price / 1.13
    when 'SEK'
      price / 11.1
    else
      price
    end
  end

  def serialize_to_proto(placements)
    placement_seq = ::FYBER::Userconfiguration::PlacementSeq.new
    placements.each do |placement|
      placement_msg = ::FYBER::Userconfiguration::Placement.new(
        id: placement.id,
        creative: placement.creatives.map { |creative| creative_to_proto(creative) }
      )
      placement_seq.placement << placement_msg
    end
    placement_seq.to_proto
  end

  def creative_to_proto(creative)
    ::FYBER::Userconfiguration::Creative.new(
      id: creative.id,
      price: creative.price,
      currency: creative.currency
    )
  end
end
