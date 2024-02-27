class CreateCreatives < ActiveRecord::Migration[7.0]
  def change
    create_table :creatives do |t|
      t.string :identifier
      t.float :price
      t.string :currency

      t.timestamps
    end
    add_index :creatives, :identifier
  end
end
