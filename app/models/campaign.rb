class Campaign < ApplicationRecord
  has_many :rewards, dependent: :destroy

  # reject_if: :all_blank will ignore any associated rewards attributes if they
  # are all blank (meaning user didn't enter anything in the fields)
  accepts_nested_attributes_for :rewards, reject_if: :all_blank,
                                          allow_destroy: true

  # validates :rewards, length: {
  #                               minimum: 2,
  #                               maximum: 10,
  #                               message: 'Please supply 2 to 10 rewards'
  #                              }

  belongs_to :user, optional: true
  validates :title, presence: true, uniqueness: true

  geocoded_by :address
  after_validation :geocode # this will make an HTTP request to Google to get
                            # the coordinates for the address

  def has_map?
    longitude.present? && latitude.present?
  end

  include AASM

  aasm whiny_transitions: false do
    state :draft, initial: true
    state :published
    state :cancelled
    state :funded
    state :unfunded

    event :publish do
      transitions from: :draft, to: :published
    end

    event :fund do
      transitions from: :published, to: :funded
    end

    event :unfund do
      transitions from: :published, to: :unfunded
    end

    event :cancel do
      transitions from: [:published, :funded], to: :cancelled
    end

    event :relaunch do
      transitions from: :cancelled, to: :draft
    end

  end
end
