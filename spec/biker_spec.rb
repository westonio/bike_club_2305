require './lib/biker'

RSpec.describe Biker do
  before(:each) do
    @biker = Biker.new("Kenny", 30)
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

    biker.log_ride(ride1, 92.5)
    biker.log_ride(ride1, 91.1)
    biker.log_ride(ride2, 60.9)
    biker.log_ride(ride2, 61.6)

    expect(biker.rides).to eq({ride1 => [92.5, 91.1], ride2 => [60.9, 61.6]})
  end
end