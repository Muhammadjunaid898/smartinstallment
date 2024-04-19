class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products, id: false do |t|
      t.references :buyer
      t.string :name
      t.date :sale_date
      t.decimal :price
      t.text :description
      t.primary_key :identification_number

      t.timestamps
    end
  end
end
