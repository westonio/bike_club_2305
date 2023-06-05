class Biker
  attr_reader :name, 
              :max_distance,
              :rides,
              :acceptable_terrain

  def initialize(name, max_distance)
    @name = name
    @max_distance = max_distance
    @rides = {}
    @acceptable_terrain = []
  end

  def learn_terrain!(terrain)
    @acceptable_terrain << terrain
  end

  def log_ride(ride, time)
    if @rides.has_key?(ride)
      @rides[ride].push(time)
    else
      @rides[ride] = [time]
    end
  end
end