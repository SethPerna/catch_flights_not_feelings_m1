class Airline < ApplicationRecord
  has_many :flights
  has_many :passengers, through: :flights

  def adult_passengers
    passengers.distinct.group(:id).where('age >= ?', 18)
  end
end
