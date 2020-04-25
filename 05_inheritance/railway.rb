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

  attr_reader stations, routes, trains

  def initialize
    @stations = []
    @routes = []
    @trains = []
  end

  def add_train
    number = get_input('Enter train number').to_i
    trains << Train.new(number)
  end

  def add_station
    name = get_input('Enter station name')
    stations << Station.new(name)
  end

  def add_route
    return 'Add at least 2 stations first' if stations.size < 2

    loop do
      station_first = choose_station
      station_last  = choose_station
      break if station_first != station_last
    end

    routes << Route.new(station_first, station_last)
  end

  private

  attr_writer stations, routes, trains

  def choose_station
  end

  def get_input(message)
    puts "#{message}:"
    gets.chomp
  end
end
