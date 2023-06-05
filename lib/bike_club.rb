class BikeClub
  attr_reader :name,
              :bikers

  def initialize(name)
    @name = name
    @bikers = []
  end

  def add_biker(biker)
    @bikers << biker
  end

  def biker_logged_most
    @bikers.max_by do |biker|
      biker.rides.values.flatten.length
    end
  end

  def biker_best_time(ride)
    @bikers.min_by do |biker|
      biker.personal_record(ride)
    end
  end
end