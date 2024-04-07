class InstallmentPlan < ApplicationRecord
  include CanCanRules

  belongs_to :company
  sequenceid :company, :installment_plans
  before_destroy :check_for_inclusion_in_plots

  validates :duration, presence: true,
                     numericality: { greater_than: 0.25, less_than_or_equal_to: 10 }

  validates :bianual_payment, :quaterly_payment, :allocation_amount,
            numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100_000_000 },
            allow_blank: true

  validates :monthly_payment, :booking_amount, presence: true,
                                numericality: { greater_than: 0, less_than_or_equal_to: 10_000_000 }

  def not_associated_with_any_plot?
    # TODO donot destroy installment plan if it is linked with any plot installment
    true
  end

  private

  def check_for_inclusion_in_plots
    # TODO donot destroy installment plan if it is linked with any plot installment
    true
  end
end
