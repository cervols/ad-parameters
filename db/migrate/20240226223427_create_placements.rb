class CreatePlacements < ActiveRecord::Migration[7.0]
  def change
    create_table :placements do |t|
      t.string :identifier
      t.float :floor
      t.string :currency

      t.timestamps
    end
    add_index :placements, :identifier
  end
end
