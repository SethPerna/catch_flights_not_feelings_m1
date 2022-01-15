require 'rails_helper'

RSpec.describe Airline, type: :model do
  it { should have_many :flights }

  describe 'instance and class methods' do
    it '#adult_passengers' do
      @frontier = Airline.create!(name: 'Frontier')
      @flight_1 = @frontier.flights.create!(number: '1', date: '1/1/22', departure_city: 'Denver', arrival_city: 'DC')
      @seth = Passenger.create!(name: 'Seth', age: 29)
      @sam = Passenger.create!(name: 'Sam', age: 27)
      @flight_pass_1 = FlightPassenger.create!(flight_id: @flight_1.id, passenger_id: @seth.id)
      @flight_pass_2 = FlightPassenger.create!(flight_id: @flight_1.id, passenger_id: @sam.id)
      @flight_2 = @frontier.flights.create!(number: '2', date: '1/2/22', departure_city: 'Denver', arrival_city: 'DC')
      @jim = Passenger.create!(name: 'Jim', age: 29)
      @josh = Passenger.create!(name: 'Josh', age: 17)
      @flight_pass_3 = FlightPassenger.create!(flight_id: @flight_2.id, passenger_id: @jim.id)
      @flight_pass_4 = FlightPassenger.create!(flight_id: @flight_2.id, passenger_id: @josh.id)
      @flight_pass_5 = FlightPassenger.create!(flight_id: @flight_2.id, passenger_id: @seth.id)
      expect(@frontier.adult_passengers).to eq([@seth, @sam, @jim])
    end
  end
end
