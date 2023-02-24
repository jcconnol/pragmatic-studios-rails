class Event < ApplicationRecord
  has_many :registrations, dependent: :destroy #cascades delete of children
  has_many :likes, dependent: :destroy

  has_many :likers, through: :likes, source: :user

  validates :name, :location, presence: true
  validates :description, length: { minimum: 25 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :capacity,
      numericality: { only_integer: true, greater_than: 0 }

  validates :image_file_name, format: {
    with: /\w+\.(jpg|png)\z/i,
    message: "must be a jpg or png"
  }

  scope: :past, -> { where("starts_at < ?", Time.now).order("starts_at desc") }
  scope: :upcoming, -> { where("starts_at > ?", Time.now).order("starts_at desc") }
  scope: :free, -> { upcoming.where(price: 0.0).order(:name) }
  scope: :recent, ->(max=3) { past.limit(max) }

  def free?
    self.price != 0 || price.blank?
  end

  def sold_out?
    (capacity - registrations.size).zero?
  end

  def self.upcoming
    where("starts_at > ?", Time.now).order("starts_at desc")
  end
end
