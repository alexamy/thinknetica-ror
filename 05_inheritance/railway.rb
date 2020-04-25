# Main class for managing railway
class Railway
  # - Управлять станциями в маршруте (добавлять, удалять)

  attr_reader :stations, :routes, :trains

  def initialize
    @stations = []
    @routes = []
    @trains = []
  end

  # simple add routines

  def add_train
    number = Ui.get_input('enter train number').to_i
    trains << Train.new(number)
  end

  def add_station
    name = Ui.get_input('enter station name')
    stations << Station.new(name)
  end

  def add_route
    return 'Add at least 2 stations first' unless validate_stations

    ends = 2.times.map { Ui.choose_from(stations) }
    routes << Route.new(*ends)
  end

  # train routines

  def add_carriage
    return 'Add trains first' unless validate_trains

    train = Ui.choose_from(trains)
    train.add_carriage(train.carriage_type.new)
  end

  def remove_carriage
    return 'Add trains first' unless validate_trains

    train = Ui.choose_from(trains)
    train.remove_carriage
  end

  def place_train_on_route
    return 'Add routes first' unless validate_routes
    return 'Add trains first' unless validate_trains

    route = Ui.choose_from(routes)
    train = Ui.choose_from(trains)
    train.place_on_route(route)
  end

  def move_train_to_next_station
    return 'Add trains first' unless validate_trains

    train = Ui.choose_from(trains)

    return 'No route assigned to train' unless train.route

    train.go_to_next_station
  end

  def move_train_to_previous_station
    return 'Add trains first' unless validate_trains

    train = Ui.choose_from(trains)

    return 'No route assigned to train' unless train.route

    train.go_to_previous_station
  end

  # station routines

  def show_stations
    Ui.print_collection(stations)
  end

  def show_trains_on_station
    return 'Add stations first' unless validate_stations

    station = Ui.choose_from(stations)
    Ui.print_collection(station.trains)
  end

  # route routines

  def add_station_to_route
    return 'Add routes first' unless validate_routes

    route = Ui.choose_from(routes)
    station = Ui.choose_from(stations)
    route.add_station(station) unless route.stations.include?(station)
  end

  def remove_station_from_route
    return 'Add routes first' unless validate_routes

    route = Ui.choose_from(routes)
    intermediate_stations = route.intermediate_stations

    return 'No intermediate stations in route' if intermediate_stations.empty?

    station = Ui.choose_from(intermediate_stations)
    route.delete_station(station)
  end

  private

  # checks
  def validate_trains
    trains.any?
  end

  def validate_stations
    stations.size >= 2
  end

  def validate_routes
    routes.any?
  end

  attr_writer :stations, :routes, :trains
end
