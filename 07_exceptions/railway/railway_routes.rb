# Routes code for railway management
module RailwayRoutes
  attr_reader :routes

  def add_route
    validate! :stations_for_route

    puts 'Choose start station:'
    start_station = Ui.choose_from(stations)
    puts 'Choose end station:'
    end_station = Ui.choose_from(stations)

    routes << Route.new(start_station, end_station)
  end

  def add_station_to_route
    validate! :routes

    route = Ui.choose_from(routes)
    station = Ui.choose_from(stations)
    is_inside = route.stations.include?(station)

    puts 'Station is inside route already' if is_inside
    route.add_station(station) unless is_inside
  end

  def remove_station_from_route
    validate! :routes

    route = Ui.choose_from(routes)
    intermediate_stations = route.intermediate_stations

    puts 'No intermediate stations in route' or return if intermediate_stations.empty?

    station = Ui.choose_from(intermediate_stations)
    route.remove_station(station)
  end

  def show_routes
    validate! :routes

    Ui.print_collection(routes)
  end

  protected

  attr_writer :routes
end
