class Product < ApplicationRecord 
  validates :name, :identification_number, presence: true
  validates_length_of :identification_number, maximum: 24, message: "can't be longer than 24 characters"
  validates :identification_number, length: { maximum: 24 }, uniqueness: true

  belongs_to :company
  # belongs_to :buyer, class_name: 'User'
end
