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
    carriage = train.carriage_type
    amount = Ui.get_input("enter #{carriage.space_key} amount")
    train.add_carriage(carriage.new(amount))
  end

  def remove_carriage_from_train
    validate! :trains

    train = Ui.choose_from(trains)
    train.remove_carriage
  end

  def use_space_in_carriage
    validate! :trains

    train = Ui.choose_from(trains)
    carriages = train.carriages

    raise 'No carriages!' if carriages.empty?

    carriage = Ui.choose_from(carriages)
    space_data = carriage.space_data

    raise 'All space occupied!' if space_data[:free].zero?

    key = space_data[:name]
    method = "occupy_#{key}".to_sym

    if key == 'seats'
      carriage.send(method)
    else
      amount = Ui.get_input('how much space to occupy')
      carriage.send(method, amount)
    end
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

    Ui.print_collection(trains) do |train|
      train.each_carriage { |carriage| puts carriage }
    end
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
