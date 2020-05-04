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

  def populate
    populate_trains
    populate_stations
  end

  protected

  def populate_trains
    links = { 0 => [0, 1], 2 => [2, 3] }
    links.each do |t_idx, c_idxs|
      c_idxs.each do |c_idx|
        trains[t_idx].add_carriage(carriages[c_idx])
      end
    end
  end

  def populate_stations
    links = { 0 => [0, 1], 1 => [2, 3] }
    links.each do |s_idx, t_idxs|
      t_idxs.each do |t_idx|
        stations[s_idx].add_train(trains[t_idx])
      end
    end
  end
end
