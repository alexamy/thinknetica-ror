# Trains code for railway management
module RailwayTrains
  attr_reader :trains

  def add_train
    train_class = get_train_class
    number = Ui.get_input('enter train number')
    trains << train_class.new(number)
  rescue StandardError => e
    puts e.message
    retry
  end

  def add_carriage_to_train
    validate! :trains

    train = Ui.choose_from(trains)

    train.add_carriage(train.carriage_type.new)
  end

  def remove_carriage_from_train
    validate! :trains

    train = Ui.choose_from(trains)
    train.remove_carriage
  end

  def place_train_on_route
    validate! :trains, :routes

    train = Ui.choose_from(trains)
    route = Ui.choose_from(routes)
    train.place_on_route(route)
  end

  def move_train_to_next_station
    validate! :trains

    train = Ui.choose_from(trains)
    route_assigned!(train)

    train.go_to_next_station
  end

  def move_train_to_previous_station
    validate! :trains

    train = Ui.choose_from(trains)
    route_assigned!(train)

    train.go_to_previous_station
  end

  def show_trains
    validate! :trains

    Ui.print_collection(trains)
  end

  protected

  attr_writer :trains

  def route_assigned!(train)
    raise 'No route assigned to train' unless train.route
  end

  def known_train!(type)
    train_class = train_classes[type]
    raise 'Unknown train type' unless train_class

    train_class
  end

  def train_classes
    {
      'cargo' => CargoTrain,
      'pass' => PassengerTrain
    }
  end

  def get_train_class
    type_message = "enter train type (#{train_classes.keys.join(', ')})"
    type = Ui.get_input(type_message).downcase
    known_train!(type)
  end
end
