# Handle train on route
module TrainRoute
  attr_reader :route, :station

  def place_on_route(route)
    self.route = route

    station&.departure_train(self)
    self.station = self.route.stations.first
    station.add_train(self)
  end

  def go_to_next_station
    station_next = route&.station_next(station)
    raise 'No next station' unless station_next

    station.departure_train(self)
    self.station = station_next
    station.add_train(self)
  end

  def go_to_previous_station
    station_previous = route&.station_previous(station)
    raise 'No previous station' unless station_previous

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

  protected

  attr_writer :route, :station
end
