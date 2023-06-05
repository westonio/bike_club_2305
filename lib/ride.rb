class Ride
  attr_reader :name, 
              :distance, 
              :terrain

  def initialize(info)
    @name = info[:name]
    @distance = info[:distance]
    @terrain = info[:terrain]
    @loop = info[:loop]
  end

  def loop?
    @loop
  end

  def total_distance
    @loop ? @distance : (@distance * 2)
  end
end