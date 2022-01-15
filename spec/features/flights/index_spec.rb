require 'rails_helper'
describe 'flights index page' do
  before do
    @frontier = Airline.create!(name: 'Frontier')
    @flight_1 = @frontier.flights.create!(number: '1', date: '1/1/22', departure_city: 'Denver', arrival_city: 'DC')
    @seth = Passenger.create!(name: 'Seth', age: 29)
    @sam = Passenger.create!(name: 'Sam', age: 27)
    @flight_pass_1 = FlightPassenger.create!(flight_id: @flight_1.id, passenger_id: @seth.id)
    @flight_pass_2 = FlightPassenger.create!(flight_id: @flight_1.id, passenger_id: @sam.id)
    @delta = Airline.create!(name: 'Delta')
    @flight_2 = @delta.flights.create!(number: '2', date: '1/2/22', departure_city: 'Denver', arrival_city: 'DC')
    @jim = Passenger.create!(name: 'Jim', age: 29)
    @josh = Passenger.create!(name: 'Josh', age: 27)
    @flight_pass_3 = FlightPassenger.create!(flight_id: @flight_2.id, passenger_id: @jim.id)
    @flight_pass_4 = FlightPassenger.create!(flight_id: @flight_2.id, passenger_id: @josh.id)
    visit '/flights'
  end
  it 'I see a list of all flight numbers, the name of the airline and the names of all passengers on that flight' do
    expect(page).to have_content("Flight: #{@flight_1.number} Airline: #{@frontier.name}")
    expect(page).to have_content("Passengers: #{@seth.name} #{@sam.name}")
    expect(page).to have_content("Flight: #{@flight_2.number} Airline: #{@delta.name}")
    expect(page).to have_content("Passengers: #{@jim.name} #{@josh.name}")
  end

  it 'I see a button to remove that passeneger whenc clicked the passenger is removed' do
    expect(page).to have_button("Remove #{@seth.name}")
    click_button("Remove #{@seth.name}")
    expect(current_path).to eq("/flights")
    expect(page).to_not have_content(@seth.name)
  end
end
