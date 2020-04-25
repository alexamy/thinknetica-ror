# Main class for managing railway
class Railway
  include RailwayStations
  include RailwayRoutes
  include RailwayTrains
  include RailwayValidator

  def initialize
    @stations = []
    @routes = []
    @trains = []
  end
end
