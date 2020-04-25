# Stations code for railway management
module RailwayStations
  attr_reader :stations

  def add_station
    name = Ui.get_input('enter station name')
    stations << Station.new(name)
  end

  def show_stations
    Ui.print_collection(stations)
  end

  def show_trains_on_station
    return 'Add stations first' unless validate_stations

    station = Ui.choose_from(stations)
    Ui.print_collection(station.trains)
  end

  protected

  attr_writer :stations

  def validate_stations
    stations.size >= 2
  end
end
