require 'rails_helper'

RSpec.describe FlightPassenger, type: :model do
  it { should belong_to :passenger }
  it { should belong_to :flight }
end
