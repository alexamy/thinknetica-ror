# Main class for managing railway
class Railway
  # - Создавать станции
  # - Создавать поезда
  # - Создавать маршруты и управлять станциями в нем (добавлять, удалять)

  # - Назначать маршрут поезду
  # - Добавлять вагоны к поезду
  # - Отцеплять вагоны от поезда
  # - Перемещать поезд по маршруту вперед и назад

  # - Просматривать список станций и список поездов на станции

  attr_reader :stations, :routes, :trains

  def initialize
    @stations = []
    @routes = []
    @trains = []
  end

  def add_train
    number = Ui.get_input('enter train number').to_i
    trains << Train.new(number)
  end

  def add_station
    name = Ui.get_input('enter station name')
    stations << Station.new(name)
  end

  def add_route
    return 'Add at least 2 stations first' if stations.size < 2

    ends = 2.times.map { Ui.choose_from(stations) }
    routes << Route.new(*ends)
  end

  private

  attr_writer :stations, :routes, :trains
end
