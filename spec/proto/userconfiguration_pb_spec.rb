require 'rails_helper'

RSpec.describe "FYBER::Userconfiguration" do
  describe 'serialization and deserialization' do
    let(:creative_1) { FYBER::Userconfiguration::Creative.new(id: 'video1', price: 10.0, currency: 'EUR') }
    let(:creative_2) { FYBER::Userconfiguration::Creative.new(id: 'video2', price: 15.0, currency: 'USD') }
    let(:placement_1) do
      FYBER::Userconfiguration::Placement.new(
        id: 'placement1',
        creative: [creative_1, creative_2]
      )
    end
    let(:placement_2) do
      FYBER::Userconfiguration::Placement.new(
        id: 'placement2',
        creative: [creative_2]
      )
    end
    let(:placement_seq) { FYBER::Userconfiguration::PlacementSeq.new(placement: [placement_1, placement_2]) }

    it 'serializes and deserializes protobuf messages' do
      # Serialize the placement_seq to a protobuf binary string
      serialized_data = placement_seq.to_proto

      # Deserialize the protobuf binary string back into a PlacementSeq object
      deserialized_placement_seq = FYBER::Userconfiguration::PlacementSeq.decode(serialized_data)

      # Test that the deserialized object matches the original placement_seq
      expect(deserialized_placement_seq).to eq(placement_seq)
    end
  end
end
