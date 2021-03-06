# Station belongs to route and can add and departure trains
class Station
  extend Validation
  include InstanceCounter

  attr_reader :name, :trains

  validate :name, :presence

  class << self
    alias all pool
  end

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

  attr_writer :name, :trains
end
