# Print all info about stations
module SeedStationsIterator
  def iterate_all
    stations.each do |station|
      print_station(station)
    end
  end

  def print_station(station)
    puts "Station #{station.name}:"
    station.each_train do |train|
      print_train(train)
    end
  end

  def print_train(train)
    print "Train #{train.number} "
    print "has #{train.carriages.size} carriage(s) "
    puts "of type #{train.carriage_type}"
    train.each_carriage do |carriage, index|
      print_carriage(carriage, index)
    end
  end

  def print_carriage(carriage, index)
    data = carriage.space_data
    print "Carriage #{index + 1} of type #{carriage.class} "
    print "has #{data[:total]} #{data[:name]} total "
    print "with #{data[:occupied]} occupied "
    puts "and #{data[:free]} free"
  end
end
