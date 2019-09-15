class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :lat
      t.string :lng
      t.string :address
    end
  end
end
