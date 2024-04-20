class Category < ApplicationRecord
  belongs_to :company
  has_many :installment_plans
end
