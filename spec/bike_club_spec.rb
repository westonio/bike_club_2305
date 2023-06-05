require './lib/bike_club'
require './lib/biker'
require './lib/ride'

RSpec.describe BikeClub do
  before(:each) do
    @club = BikeClub.new("Boulder Bicycling")
  end

  it 'exists' do
    expect(@club).to be_a(BikeClub)
  end

  it 'has a name' do
    expect(@club.name).to eq("Boulder Bicycling")
  end

  it 'starts with no bikers' do
    expect(@club.bikers).to eq([])
  end

  it 'can add bikers' do
    kenny = Biker.new("Kenny", 30)
    athena = Biker.new("Athena", 15)
    sara = Biker.new("Sara", 38)
    @club.add_biker(kenny)
    @club.add_biker(athena)
    @club.add_biker(sara)

    expect(@club.bikers).to eq([kenny, athena, sara])
  end

  it 'can determine which biker has most rides' do
    kenny = Biker.new("Kenny", 30)
    athena = Biker.new("Athena", 15)
    @club.add_biker(kenny)
    @club.add_biker(athena)
    ride = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
    kenny.learn_terrain!(:gravel)
    athena.learn_terrain!(:gravel)

    5.times {kenny.log_ride(ride, 90.4)}
    8.times {athena.log_ride(ride, 87.3)}

    expect(@club.biker_logged_most).not_to eq(kenny)
    expect(@club.biker_logged_most).to eq(athena)
  end

  it 'can determine which biker has best time for given ride' do
    kenny = Biker.new("Kenny", 30)
    athena = Biker.new("Athena", 15)
    @club.add_biker(kenny)
    @club.add_biker(athena)
    ride = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
    kenny.learn_terrain!(:gravel)
    athena.learn_terrain!(:gravel)

    kenny.log_ride(ride, 90.4)
    athena.log_ride(ride, 87.3)

    expect(@club.biker_best_time(ride)).not_to eq(kenny)
    expect(@club.biker_best_time(ride)).to eq(athena)
  end
end