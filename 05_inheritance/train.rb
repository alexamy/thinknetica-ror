# frozen_string_literal: true

# Train can move, has carriage and optional route
class Train
  attr_accessor :number, :type, :carriages_count,
                :velocity, :route, :station

  def initialize(number, type, carriages_count)
    @number = number
    @type = type
    @carriages_count = carriages_count
    @velocity = 0
  end

  def add_velocity(gain = 10)
    self.velocity += gain if gain.positive?
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

  def set_route(route_target)
    self.route = route_target

    station&.departure_train(self)
    self.station = route.stations.first
    station.add_train(self)
  end

  def go_to_next_station
    station_next = route&.station_next(station)
    return unless station_next

    station.departure_train(self)
    self.station = station_next
    station.add_train(self)
  end

  def go_to_previous_station
    station_previous = route&.station_previous(station)
    return unless station_previous

    station.departure_train(self)
    self.station = station_previous
    station.add_train(self)
  end

  def station_next
    route&.station_next(station)
  end

  def station_previous
    route&.station_previous(station)
  end
end

# Cargo train
class CargoTrain < Train
end

# Passenger train
class PassengerTrain < Train
end
