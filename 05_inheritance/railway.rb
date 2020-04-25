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
    number = get_input('enter train number').to_i
    trains << Train.new(number)
  end

  def add_station
    name = get_input('enter station name')
    stations << Station.new(name)
  end

  def add_route
    return 'Add at least 2 stations first' if stations.size < 2

    routes << Route.new(*choose_route_stations)
  end

  private

  attr_writer :stations, :routes, :trains

  # :reek:DuplicateMethodCall
  def choose_route_stations
    loop do
      station_first = choose_from(stations)
      station_last  = choose_from(stations)
      break if station_first != station_last
    end
    [station_first, station_last]
  end

  def choose_from(collection)
    loop do
      print_collection(collection)
      index = get_input('your option').to_i
      result = collection[index]
      if result
        return result
      else
        puts 'Unknown index'
    end
  end

  def print_collection(collection)
    collection.each.with_index do |item, index|
      puts "#{index}. #{item}"
    end
  end

  def get_input(message)
    print "#{message.capitalize}: "
    gets.chomp
  end
end
