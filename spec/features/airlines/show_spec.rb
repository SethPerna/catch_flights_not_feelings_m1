require 'rails_helper'
describe 'airline show page' do
  before do
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
    visit "/airlines/#{@frontier.id}"
  end
  it 'I see a unique list of adult passengers that have flights on that airline' do
    expect(page).to have_content("Passengers: #{@seth.name} #{@sam.name} #{@jim.name}")
    expect(page).to_not have_content(@josh.name)
  end
end
describe 'sorted list on show page' do #new describe to exit before block
  it 'I see the list is sorted by the number of flights taken, most to least' do
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
    @flight_pass_5 = FlightPassenger.create!(flight_id: @flight_2.id, passenger_id: @sam.id)
    @flight_3 = @frontier.flights.create!(number: '3', date: '1/2/22', departure_city: 'Denver', arrival_city: 'DC')
    @flight_pass_6 = FlightPassenger.create!(flight_id: @flight_3.id, passenger_id: @sam.id)
    @flight_pass_7 = FlightPassenger.create!(flight_id: @flight_3.id, passenger_id: @seth.id)
    # sam 3 flights, seth 2 flights, jim one flight
    visit "/airlines/#{@frontier.id}"
    expect(page).to have_content("Passengers: #{@sam.name} #{@seth.name} #{@jim.name}")
  end
end
