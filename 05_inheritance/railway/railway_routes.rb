# Routes code for railway management
module RailwayRoutes
  attr_reader :routes

  def add_route
    return unless validate(:stations_for_route)

    puts 'Choose start and end stations:'
    ends = 2.times.map { Ui.choose_from(stations) }
    routes << Route.new(*ends)
  end

  def add_station_to_route
    return unless validate(:routes)

    route = Ui.choose_from(routes)
    station = Ui.choose_from(stations)
    route.add_station(station) unless route.stations.include?(station)
  end

  def remove_station_from_route
    return unless validate(:routes)

    intermediate_stations = intermediate_stations_in_route
    return 'No intermediate stations in route' if intermediate_stations.empty?

    station = Ui.choose_from(intermediate_stations)
    route.remove_station(station)
  end

  protected

  attr_writer :routes

  def intermediate_stations_in_route
    route = Ui.choose_from(routes)
    route.intermediate_stations
  end
end
