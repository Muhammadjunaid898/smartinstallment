class Company < ApplicationRecord
  validates :name,      length:    { minimum: 3, maximum: 35 }, uniqueness: { case_sensitive: false }
  validates :subdomain, format:    { with: /\A([a-zA-Z0-9]*[a-zA-Z]+[a-zA-Z0-9]*)\z/ }
  validates :subdomain, length:    { minimum: 3, maximum: 35 }, uniqueness: { message: "has already been taken, change the company name", case_sensitive: false }
  before_validation :setup_subdomain, :if=> :new_record?

  has_many :users
  has_many :installment_plans
  has_many  :categories

  not_multitenant!

  def self.current_tenant_id=(tenant_id)
    Thread.current[:tenant_id] = tenant_id
    if tenant_id.present?
      Thread.current[:tenant] = find_by(id: tenant_id)
    else
      Thread.current[:tenant] = nil
    end
  end

  def self.current_tenant_id
    Thread.current[:tenant_id]
  end

  def self.current_tenant=(company)
    if company.present?
      Thread.current[:tenant] = company
      Thread.current[:tenant_id] = company.id
    else
      Thread.current[:tenant] = nil
      Thread.current[:tenant_id] = nil
    end
  end

  def self.current_tenant
    Thread.current[:tenant]
  end

  private

  def setup_subdomain
    self.subdomain = self.name.gsub(/[^0-9A-Za-z]/, '')
  end
end
