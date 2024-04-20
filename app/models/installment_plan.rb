class InstallmentPlan < ApplicationRecord
  include CanCanRules

  belongs_to :company
  belongs_to :category
  sequenceid :company, :installment_plans
  before_destroy :check_for_inclusion_in_plots
  validate :must_have_payment_amount

  validates :no_of_biannual_or_quarterly_payments, :no_of_monthly_payments, presence: true,
                     numericality: { greater_than: 0, less_than_or_equal_to: 100_000_000 }

  validates :biannual_payment, :quarterly_payment, :allocation_amount,
            numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100_000_000 },
            allow_blank: true

  validates :monthly_payment, :booking_amount, presence: true,
                                numericality: { greater_than: 0, less_than_or_equal_to: 10_000_000 }

  attr_accessor :payment_frequency

  def not_associated_with_any_plot?
    # TODO donot destroy installment plan if it is linked with any plot installment
    true
  end

  def total_price
    price = booking_amount
    price += allocation_amount if allocation_amount.present?
    price += (monthly_payment * no_of_monthly_payments)
    price += (biannual_payment * no_of_biannual_or_quarterly_payments) if biannual_payment.present?
    price += (quarterly_payment * no_of_biannual_or_quarterly_payments) if quarterly_payment.present?
    price
  end

  private

  def must_have_payment_amount
    unless biannual_payment.present? || quarterly_payment.present?
      errors.add(:base, "Please enter either biannual or quarterly payment amount")
    end
  end

  def check_for_inclusion_in_plots
    # TODO donot destroy installment plan if it is linked with any plot installment
    true
  end
end
