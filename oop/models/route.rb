# Route has stations
class Route
  include InstanceCounter
  include InitValidator

  attr_reader :stations

  def initialize(station_start, station_end)
    @stations = [station_start, station_end]
    validate!
    register_instance
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def remove_station(station_target)
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

  def intermediate_stations
    stations[1..-2]
  end

  def to_s
    "Route with #{stations.size} stations,"\
    " start: #{stations.first},"\
    " end: #{stations.last}"
  end

  protected

  attr_writer :stations

  def validate!
    correct_type = stations.all? do |station|
      station.class.ancestors.include?(Station)
    end
    error_msg = 'Objects in stations array must have Station class'
    raise error_msg unless correct_type
  end
end
