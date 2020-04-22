module TrainType
  CARGO = 1
  PASSENGER = 2
end

# Station belongs to route and can add and departure trains
class Station
  attr_accessor :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    trains << train
  end

  def departure_train(train)
    trains.delete(train)
  end

  def trains_available_by_type(type)
    trains.select { |train| train.type == type }.size
  end
end

# Route has stations
class Route
  attr_accessor :stations

  def initialize(station_start, station_end)
    @stations = [station_start, station_end]
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def delete_station(station_target)
    stations.delete_if.with_index do |station, index|
      next false if index.zero? || index == stations.size - 1

      station == station_target
    end
  end
end

# Train can move, has carriage and optional route
class Train
  attr_reader :route
  attr_accessor :number, :type, :carriages_count,
                :velocity, :station_index

  def initialize(number, type, carriages_count)
    @number = number
    @type = type
    @carriages_count = carriages_count
    @velocity = 0
  end

  def add_velocity(gain = 10)
    self.velocity += gain
  end

  def stop
    self.velocity = 0
  end

  def stopped?
    velocity.zero?
  end

  def carriage?
    carriages_count.positive?
  end

  def add_carriage
    self.carriages_count += 1 if stopped?
  end

  def remove_carriage
    self.carriages_count -= 1 if stopped? && carriage?
  end

  def route=(route_target)
    route.stations[station_index].departure_train(self) if route

    self.route = route_target
    self.station_index = 0
    route.stations[station_index].add_train(self)
  end

  def go_to_next_station
    return unless route && station_index < route.stations.size - 1

    route.stations[station_index].departure_train(self)
    self.station_index += 1
    route.stations[station_index].add_train(self)
  end

  def station_previous
    return unless route && station_index.positive?

    route.stations[station_index - 1]
  end

  def station_current
    route.stations[station_index] if route
  end

  def station_next
    route.stations[station_index + 1] if route
  end
end
