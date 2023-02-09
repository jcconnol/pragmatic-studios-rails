class Event < ApplicationRecord
  def free?
    self.price.zero? || price.blank?
  end
end
