class AddColumnsAndIndexesOnUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :full_name, :string
    add_column :users, :company_id, :integer, index: true
    add_column :users, :status, :integer, default: 1
    add_column :users, :created_by_id, :integer

    remove_index :users, :email
    add_index :users, %i[full_name company_id]
    add_index :users, %i[email company_id], unique: true
  end
end
