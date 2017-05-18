class Pledge < ApplicationRecord
  belongs_to :campaign
  belongs_to :user

  validates :amount, numericality: { greater_than: 0 }
end
