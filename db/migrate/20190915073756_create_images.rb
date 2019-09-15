class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string :raw
      t.string :full
      t.string :regular
      t.string :small
      t.string :thumb
      t.references :location, foreign_key: true

      t.timestamps
    end
  end
end
