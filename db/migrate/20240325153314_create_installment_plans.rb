class CreateInstallmentPlans < ActiveRecord::Migration[6.1]
  def change
    create_table :installment_plans do |t|
      t.integer :company_id
      t.integer :booking_amount
      t.integer :allocation_amount
      t.integer :bianual_payment
      t.integer :monthly_payment
      t.integer :quaterly_payment
      t.decimal :duration, default: 1, precision: 4, scale: 2

      t.timestamps
    end
  end
end
