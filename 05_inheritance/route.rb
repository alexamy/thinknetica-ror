# Route has stations
class Route
  attr_accessor :stations

  def initialize(station_start, station_end)
    @stations = [station_start, station_end]
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def delete_station(station_target)
    stations.delete_if.with_index do |station, index|
      next false if index.zero? || index == stations.size - 1

      station == station_target
    end
  end

  def show_stations
    stations.each { |station| puts station.name }
  end

  def station_next(station)
    current_index = stations.index(station)
    return unless current_index

    stations[current_index + 1]
  end

  def station_previous(station)
    current_index = stations.index(station)
    return unless current_index&.positive?

    stations[current_index - 1]
  end
end
