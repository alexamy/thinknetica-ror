# Routes code for railway management
module RailwayRoutes
  attr_reader :routes

  def add_route
    return 'Add at least 2 stations first' unless validate_stations

    ends = 2.times.map { Ui.choose_from(stations) }
    routes << Route.new(*ends)
  end

  def add_station_to_route
    return 'Add routes first' unless validate_routes

    route = Ui.choose_from(routes)
    station = Ui.choose_from(stations)
    route.add_station(station) unless route.stations.include?(station)
  end

  def remove_station_from_route
    intermediate_stations = intermediate_stations_in_route

    return 'No intermediate stations in route' if intermediate_stations.empty?

    station = Ui.choose_from(intermediate_stations)
    route.remove_station(station)
  end

  protected

  attr_writer :routes

  def validate_routes
    routes.any?
  end

  def intermediate_stations_in_route
    return 'Add routes first' unless validate_routes

    route = Ui.choose_from(routes)
    route.intermediate_stations
  end
end
