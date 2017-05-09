class Reward < ApplicationRecord
  belongs_to :campaign, optional: true

  validates :title, presence: true
  validates :amount, presence: true
end
