# Seed data for testing
class Seed
  include SeedStationsIterator

  attr_accessor :trains, :stations, :routes, :carriages

  def initialize
    @stations = Seed.sample_stations
    @routes = Seed.sample_routes(@stations)
    @trains = Seed.sample_trains
    @carriages = Seed.sample_carriages
    populate
  end

  def populate
    trains[0].add_carriage(carriages[0])
    trains[0].add_carriage(carriages[1])
    trains[2].add_carriage(carriages[2])
    trains[2].add_carriage(carriages[3])
    stations[0].add_train(trains[0])
    stations[0].add_train(trains[1])
    stations[1].add_train(trains[2])
    stations[1].add_train(trains[3])
  end

  def self.sample_stations
    %w[Stockton Minneapolis Garland Seattle Jacksonville]
      .map { |station| Station.new(station) }
  end

  def self.sample_routes(stations)
    [Route.new(stations.first, stations.last)]
  end

  def self.sample_trains
    [
      CargoTrain.new('100-11'),
      CargoTrain.new('200-22'),
      PassengerTrain.new('300-33'),
      PassengerTrain.new('400-44')
    ]
  end

  def self.sample_carriages
    [
      CargoCarriage.new(500),
      CargoCarriage.new(500),
      PassengerCarriage.new(50),
      PassengerCarriage.new(20)
    ]
  end
end
