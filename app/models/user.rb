class User < ApplicationRecord
  include CanCanRules

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :company
  belongs_to :created_by, class_name: 'User', optional: true

  attr_accessor :new_company_member
  accepts_nested_attributes_for :company

  def password_required?
    return false if new_company_member

    super
  end

  def self.current_user
    Thread.current[:current_user]
  end

  def self.current_user=(user)
    Thread.current[:current_user] = user
  end

  def self.current_ability
    Thread.current[:current_ability]
  end

  def self.current_ability=(ability)
    Thread.current[:current_ability] = ability
  end

  def self.having_email_without_multitenancy(email)
    unscoped.find_by(email: email)
  end
end
