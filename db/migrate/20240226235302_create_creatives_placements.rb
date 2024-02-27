class CreateCreativesPlacements < ActiveRecord::Migration[7.0]
  def change
    create_table :creatives_placements, id: false do |t|
      t.belongs_to :creative
      t.belongs_to :placement
    end
  end
end
