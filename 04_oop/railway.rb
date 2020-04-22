# frozen_string_literal: true

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

  def show_stations
    stations.each { |station| puts station.name }
  end

  def station_next(station)
    current_index = stations.index(station)
    return unless current_index

    stations[current_index + 1]
  end

  def station_previous(station)
    current_index = stations.index(station)
    return unless current_index&.positive?

    stations[current_index - 1]
  end
end

# Train can move, has carriage and optional route
class Train
  attr_reader :route
  attr_accessor :number, :type, :carriages_count,
                :velocity, :station

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
    station&.departure_train(self)
    self.route = route_target
    self.station = route[0]
    station.add_train(self)
  end

  def go_to_next_station
    station_next = route&.station_next(station)
    return unless station_next

    station.departure_train(self)
    station = station_next
    station.add_train(self)
  end

  def go_to_previous_station
    station_previous = route&.station_previous(station)
    return unless station_previous

    station.departure_train(self)
    station = station_previous
    station.add_train(self)
  end

  def station_previous
    route&.station_next(station)
  end

  def station_next
    route&.station_previous(station)
  end
end
