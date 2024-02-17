class CreateCompanies < ActiveRecord::Migration[6.1]
  def self.up
    create_table :companies do |t|
      t.string :name
      t.string :subdomain
      t.date :creation_date
      t.integer :admin_id

      t.timestamps
    end
  end

  def self.down
    drop_table :companies
  end
end
