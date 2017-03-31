class Campaign < ApplicationRecord
  validates :title, presence: true, uniqueness: true
end
