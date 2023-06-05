require './lib/biker'
require './lib/ride'

RSpec.describe Biker do
  before(:each) do
    @biker = Biker.new("Kenny", 30)
    @biker2 = Biker.new("Athena", 15)
  end

  it 'exists' do
    expect(@biker).to be_a(Biker)
  end

  it 'has a name' do
    expect(@biker.name).to eq("Kenny")
  end

  it 'has a max distance' do
    expect(@biker.max_distance).to eq(30)
  end

  it 'starts with no rides and no known terrain' do
    expect(@biker.rides).to be_empty #this is empty hash
    expect(@biker.acceptable_terrain).to be_empty #this is empty array
  end

  it 'can learn a new terrain' do
    @biker.learn_terrain!(:gravel)
    @biker.learn_terrain!(:hills)
    
    expect(@biker.acceptable_terrain).to eq([:gravel, :hills])
  end

  it 'can log rides' do
    ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
    ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
    @biker.learn_terrain!(:gravel)
    @biker.learn_terrain!(:hills)

    @biker.log_ride(ride1, 92.5)
    @biker.log_ride(ride1, 91.1)
    @biker.log_ride(ride2, 60.9)
    @biker.log_ride(ride2, 61.6)

    expect(@biker.rides).to eq({ride1 => [92.5, 91.1], ride2 => [60.9, 61.6]})
  end

  it 'cannot log a ride if terrain not known yet' do
    ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
    ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
    @biker2.log_ride(ride1, 97.0)
    @biker2.log_ride(ride2, 67.0)

    expect(@biker2.rides).to eq({})
  end

  it 'cannot log ride if total distance is further than rider max distance' do
    @biker2.learn_terrain!(:gravel)
    @biker2.learn_terrain!(:hills)
    ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
    ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
    @biker2.log_ride(ride1, 97.0) #this ride has distance over rider max
    @biker2.log_ride(ride2, 67.0) #distance is below max and rider knows terrain

    expect(@biker2.rides).to eq({ride2 => [67.0]})
  end

  it 'returns personal record for ride' do
    ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
    @biker.log_ride(ride1, 92.5)
    @biker.log_ride(ride1, 91.1)
    ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
    @biker.log_ride(ride2, 60.9)
    @biker.log_ride(ride2, 61.6)

    expect(@biker.personal_record(ride1)).to eq(91.1)
    expect(@biker.personal_record(ride2)).to eq(60.9)
  end

  it 'returns false if ride cannot be achieved' do
    ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
    ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
    @biker2.log_ride(ride1, 92.5)
    @biker2.log_ride(ride1, 91.1)
   
    expect(@biker2.personal_record(ride1)).to eq(false)
    expect(@biker2.personal_record(ride2)).to eq(65.0)
  end
end