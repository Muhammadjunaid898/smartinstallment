class UpdateProducts < ActiveRecord::Migration[6.1]
  def change
    remove_column :products, :price
    remove_column :products, :identification_number
    add_reference :products, :company
    add_column :products, :id, :primary_key
    add_column :products, :installments_start_date, :date
    add_column :products, :identification_number, :integer
    add_index :products, :identification_number, unique: true
  end
end
