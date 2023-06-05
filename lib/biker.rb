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
    add_ride(ride, time) if can_ride?(ride)
  end

  def can_ride?(ride)
    ride.total_distance <= @max_distance && @acceptable_terrain.include?(ride.terrain)
  end 

  def add_ride(ride, time)
    if @rides.has_key?(ride)
      @rides[ride].push(time)
    else
      @rides[ride] = [time]
    end
  end

  def personal_record(ride)
    if can_ride?(ride)
      @rides[ride].min 
    else
      false
    end
  end
end