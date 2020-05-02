# Seed data for testing
class Seed
  attr_accessor :trains, :stations, :routes, :carriages

  def initialize
    @stations = Seed.sample_stations
    @routes = Seed.sample_routes(@stations)
    @trains = Seed.sample_trains
    @carriages = Seed.sample_carriages
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
