module TrainType
  CARGO = 1
  PASSENGER = 2
end

# station
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
    trains.select { |t| t.type == type }.size
  end
end

# route
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
      next false if index == 0 || index == stations.size - 1
      station == station_target
    end
  end
end

# train
class Train
  attr_accessor :number, :type, :carriages_count,
                :velocity, :route, :station_index

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
    velocity == 0
  end

  def has_carriage?
    carriages_count > 0
  end

  def add_carriage
    self.carriages_count += 1 if stopped?
  end

  def remove_carriage
    self.carriages_count -= 1 if stopped? && has_carriage?
  end

  def set_route(route_target)
    route.stations[station_index].departure_train(self) if route

    self.route = route_target
    self.station_index = 0
    route.stations[station_index].add_train(self)
  end

  def go_to_next_station
    if route && station_index < route.stations.size - 1
      route.stations[station_index].departure_train(self)
      self.station_index += 1
      route.stations[station_index].add_train(self)
    end
  end

  def station_previous
    if route && station_index > 0
      route.stations[station_index - 1]
    end
  end

  def station_current
    route.stations[station_index] if route
  end

  def station_next
    route.stations[station_index + 1] if route
  end
end

t1 = Train.new(101, TrainType::CARGO, 3)
t2 = Train.new(202, TrainType::PASSENGER, 1)

s1 = Station.new('Aklahoma')
s2 = Station.new('Olabama')
s3 = Station.new('NY')

r1 = Route.new(s1, s3)
r1.add_station(s2)

puts t1.inspect

t1.set_route(r1)
puts t1.route.inspect

t1.go_to_next_station
t1.go_to_next_station
puts t1.station_previous.inspect, t1.station_current.inspect, t1.station_next.inspect
