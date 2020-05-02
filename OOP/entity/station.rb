# Station belongs to route and can add and departure trains
class Station
  include InstanceCounter
  include InitValidator

  class << self
    alias all pool
  end

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
    validate!
    register_instance
  end

  def add_train(train)
    trains << train
  end

  def departure_train(train)
    trains.delete(train)
  end

  def trains_available_by_class(class_name)
    trains.select { |train| train.class == class_name }.size
  end

  def each_train
    trains.each { |train| yield train }
  end

  def to_s
    "Station #{name} with #{trains.size} trains"
  end

  protected

  def validate!
    raise 'Empty name!' unless name
  end

  attr_writer :name, :trains
end
