# Seed data for testing
class Seed
  attr_accessor :trains, :stations, :routes, :carriages

  def initialize
    @stations = Seed.sample_stations
    @routes = Seed.sample_routes(@stations)
    @trains = Seed.sample_trains
    @carriages = Seed.sample_carriages
  end

  def iterate_all
    stations.each do |station|
      station.each_train do |train|
        print_train_info(train)
        train.each_carriage.with_index(1) do |carriage, index|
          puts "Carriage #{index} of type #{carriage.class}"
          print_carriage_info(carriage)
        end
      end
    end
  end

  def print_train_info(train)
    puts "Train #{train.number}"
    puts "has #{trains.carriages.size} carriage(s)"
    puts "of type #{train.carriage_type}"
  end

  def print_carriage_info(carriage)
    data = get_places_data(carriage)
    puts "Has #{data[:total]} #{prefix} total"
    puts "with #{data[:occupied]} occupied"
    puts "and #{data[:free]} free"
  end

  def get_places_data(carriage)
    prefixes = { 'CargoCarriage' => 'volume', 'PassengerCarriage' => 'seats' }
    raise 'Unknown carriage type' unless prefixes.include?(carriage.class)

    prefix = prefixes[carriage.class]
    {
      total: carriage.send(prefix),
      occupied: carriage.send("#{prefix}_occupied"),
      free: carriage.send("#{prefix}_free"),
    }
  end

  def self.sample_stations
    %w[Stockton Minneapolis Garland Seattle Jacksonville]
      .map { |station| Station.new(station) }
  end

  def self.sample_routes(stations)
    [Route.new(stations.first, stations.last)]
  end

  def self.sample_trains
    types = [CargoTrain, PassengerTrain]
    (1..9).map do |i|
      types.sample.new("#{i}00-#{i}#{i}")
    end
  end

  def self.sample_carriages
    types = [CargoCarriage, PassengerCarriage]
    carriages = 10.step(100, 5).map do |i|
      types.sample.new(i) if rand > 0.5
    end
    carriages.compact
  end
end
