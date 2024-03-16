class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :company
  belongs_to :created_by, class_name: 'User', optional: true

  accepts_nested_attributes_for :company

  def self.having_email_without_multitenancy(email)
    unscoped.find_by(email: email)
  end
end
