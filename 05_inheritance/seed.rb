# Seed data for testing
class Seed
  attr_accessor :trains, :stations, :routes, :carriages

  def initialize
    @stations = sample_stations
    @routes = sample_routes
    @trains = sample_trains
    @carriages = sample_carriages
  end

  def sample_stations
    %w[Stockton Minneapolis Garland Seattle Jacksonville]
      .map { |station| Station.new(station) }
  end

  def sample_routes
    [Route.new(stations.first, stations.last)]
  end

  def sample_trains
    [
      CargoTrain.new(101, 2),
      CargoTrain.new(202, 0),
      PassengerTrain.new(303, 3),
      PassengerTrain.new(404, 1)
    ]
  end

  def sample_carriages
    [
      CargoCarriage.new,
      CargoCarriage.new,
      PassengerCarriage.new,
      PassengerCarriage.new
    ]
  end
end
