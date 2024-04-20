class CreateInstallmentPlans < ActiveRecord::Migration[6.1]
  def change
    create_table :installment_plans do |t|
      t.integer :company_id
      t.integer :booking_amount
      t.integer :allocation_amount
      t.integer :biannual_payment
      t.integer :monthly_payment
      t.integer :quarterly_payment
      t.integer :no_of_monthly_payments
      t.integer :no_of_biannual_or_quarterly_payments
      t.integer :category_id

      t.timestamps
    end
  end
end
