class Train
  attr_accessor :number, :type, :carriages_count

  def initialize(number, type, carriages_count)
    @number = number
    @type = type
    @carriages_count = carriages_count
  end
end

class Route
  attr_accessor :stations, :trains

  def initialize(station_start, station_end)
    @stations = [station_start, station_end]
    @trains = []
  end
end

class Station
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end
