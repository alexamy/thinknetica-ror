# Train can move, has carriage and optional route
class Train
  include TrainRoute
  include InstanceCounter
  include Manufacturer
  include InitValidator

  NUMBER_FORMAT = /^[a-z\d]{3}-?[a-z\d]{2}$/i.freeze

  attr_reader :number, :type, :carriages, :velocity

  def self.find(number)
    pool.find { |train| train.number == number }
  end

  def initialize(number)
    @number = number.to_s
    @carriages = []
    @velocity = 0

    validate!
    register_instance
  end

  def carriage_type
    Carriage
  end

  def add_velocity(gain = 10)
    self.velocity += gain if gain.positive?
  end

  def stop
    self.velocity = 0
  end

  def stopped?
    velocity.zero?
  end

  def carriage?
    carriages.size.positive?
  end

  def add_carriage(carriage)
    raise 'Train must be stopped' unless stopped?
    raise "Can add only #{carriage_type}" unless carriage.class == carriage_type

    carriages << carriage
  end

  def remove_carriage
    carriages.pop if stopped? && carriage?
  end

  def each_carriage
    carriages.each_with_index do |carriage, index|
      yield(carriage, index)
    end
  end

  def to_s
    "Train #{number}"\
    " with #{carriages.size} carriages"\
    " of type #{carriage_type}"\
    " #{station ? 'on station ' + station.name : 'is not on route'}"
  end

  protected

  attr_writer :number, :carriages, :velocity

  def validate!
    raise 'Empty number!' unless number
    raise 'Bad number format!' unless number =~ NUMBER_FORMAT
  end
end

# Cargo train
class CargoTrain < Train
  def carriage_type
    CargoCarriage
  end
end

# Passenger train
class PassengerTrain < Train
  def carriage_type
    PassengerCarriage
  end
end
