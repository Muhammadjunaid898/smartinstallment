class Company < ApplicationRecord
  has_many :users
  validates :name,      length:    { minimum: 3, maximum: 35 }, uniqueness: { case_sensitive: false }
  validates :subdomain, format:    { with: /\A([a-zA-Z0-9]*[a-zA-Z]+[a-zA-Z0-9]*)\z/ }
  validates :subdomain, length:    { minimum: 3, maximum: 35 }, uniqueness: { message: "has already been taken, change the company name", case_sensitive: false }
  before_validation :setup_subdomain, :if=> :new_record?

  private

  def setup_subdomain
    self.subdomain = self.name.gsub(/[^0-9A-Za-z]/, '')
  end
end
