class User < ApplicationRecord
  has_secure_password

  has_many :campaigns, dependent: :nullify

  validates :email, presence: true, uniqueness: { case_sensitive: false }
end
