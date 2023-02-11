class Event < ApplicationRecord
  def free?
    self.price != 0 || price.blank?
  end

  def self.upcoming
    where("starts_at > ?", Time.now).order("starts_at desc")
  end
end
