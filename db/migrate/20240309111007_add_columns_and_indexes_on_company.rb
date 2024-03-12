class AddColumnsAndIndexesOnCompany < ActiveRecord::Migration[6.1]
  def change
    # Add unique indexes
    add_index :companies, :name, unique: true
    add_index :companies, :subdomain, unique: true
    add_index :companies, [:admin_id, :name], unique: true

    # Add column
    add_column :companies, :phone_number, :string
  end
end
