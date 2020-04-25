# Trains code for railway management
module RailwayTrains
  attr_reader :trains

  def add_train
    number = Ui.get_input('enter train number').to_i
    trains << Train.new(number)
  end

  def add_carriage
    return unless validate(:trains)

    train = Ui.choose_from(trains)
    train.add_carriage(train.carriage_type.new)
  end

  def remove_carriage
    return unless validate(:trains)

    train = Ui.choose_from(trains)
    train.remove_carriage
  end

  def place_train_on_route
    return unless validate(:routes)
    return unless validate(:trains)

    route = Ui.choose_from(routes)
    train = Ui.choose_from(trains)
    train.place_on_route(route)
  end

  def move_train_to_next_station
    return unless validate(:trains)

    train = Ui.choose_from(trains)

    return 'No route assigned to train' unless train.route

    train.go_to_next_station
  end

  def move_train_to_previous_station
    return unless validate(:trains)

    train = Ui.choose_from(trains)

    return 'No route assigned to train' unless train.route

    train.go_to_previous_station
  end

  protected

  attr_writer :trains
end
