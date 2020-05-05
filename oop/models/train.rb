# Train can move, has carriage and optional route
class Train
  extend Accessors

  include TrainRoute
  include InstanceCounter
  include Manufacturer

  NUMBER_FORMAT = /^[a-z\d]{3}-?[a-z\d]{2}$/i.freeze

  attr_reader :number, :type, :carriages, :velocity

  attr_accessor_with_history :mark
  strong_attr_accessor :stamp, Integer

  def self.find(number)
    pool.find { |train| train.number == number }
  end

  def initialize(number)
    @number = number.to_s
    @carriages = []
    @velocity = 0

    register_instance
  end

  def set_custom_accessors(mark_val, stamp_val)
    self.mark = mark_val
    self.stamp = stamp_val
    puts mark.inspect, mark_history.inspect, stamp.inspect
    puts
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
end

# Cargo train
class CargoTrain < Train
  extend Validation
  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT

  def initialize(number)
    super
    validate!
  end

  def carriage_type
    CargoCarriage
  end
end

# Passenger train
class PassengerTrain < Train
  extend Validation
  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT

  def initialize(number)
    super
    validate!
  end

  def carriage_type
    PassengerCarriage
  end
end
