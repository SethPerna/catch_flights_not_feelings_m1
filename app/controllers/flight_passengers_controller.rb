class FlightPassengersController < ApplicationController
  def destroy
    flight = Flight.find(params[:flight_id])
    passenger = Passenger.find(params[:passenger_id])
    flight_passenger = FlightPassenger.find_by(flight_id: params[:flight_id], passenger_id: params[:passenger_id])
    flight_passenger.destroy
    redirect_to "/flights"
  end
end
