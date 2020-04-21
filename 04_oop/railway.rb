module TrainType
  CARGO = 1
  PASSENGER = 2
end

class Train
  attr_accessor :number, :type, :carriages_count

  def initialize(number, type, carriages_count)
    @number = number
    @type = type
    @carriages_count = carriages_count
  end
end

class Route
  attr_accessor :stations

  def initialize(station_start, station_end)
    @stations = [station_start, station_end]
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def remove_station(station)
    stations.delete(station)
  end

  def show_stations
    puts stations
  end
end

class Station
  attr_accessor :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end
end
