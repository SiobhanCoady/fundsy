class Campaign < ApplicationRecord
  has_many :rewards, dependent: :destroy

  # reject_if: :all_blank will ignore any associated rewards attributes if they
  # are all blank (meaning user didn't enter anything in the fields)
  accepts_nested_attributes_for :rewards, reject_if: :all_blank,
                                          allow_destroy: true

  validates :rewards, length: {
                                minimum: 2,
                                maximum: 10,
                                message: 'Please supply 2 to 10 rewards'
                               }

  belongs_to :user, optional: true
  validates :title, presence: true, uniqueness: true
end
