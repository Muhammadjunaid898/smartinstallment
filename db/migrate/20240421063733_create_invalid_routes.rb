class CreateInvalidRoutes < ActiveRecord::Migration[6.1]
  def change
    create_table :invalid_routes do |t|
      t.string :url
      t.string :relative_path
      t.string :request_type

      t.timestamps
    end
  end
end
