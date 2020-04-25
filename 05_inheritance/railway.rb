# Main class for managing railway
class Railway
  # - Управлять станциями в маршруте (добавлять, удалять)
  # - Перемещать поезд по маршруту вперед и назад

  # - Просматривать список станций и список поездов на станции

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
    return 'Add trains first' unless validate_trains
    return 'Add routes first' unless validate_routes

    route = Ui.choose_from(routes)
    train = Ui.choose_from(trains)
    train.place_on_route(route)
  end

  private

  # checks
  def validate_trains
    trains.size.positive?
  end

  def validate_stations
    stations.size >= 2
  end

  def validate_routes
    routes.size.positive?
  end

  attr_writer :stations, :routes, :trains
end
