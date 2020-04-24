# frozen_string_literal: true

# Station belongs to route and can add and departure trains
class Station
  attr_accessor :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    trains << train
  end

  def departure_train(train)
    trains.delete(train)
  end

  def trains_available_by_type(type)
    trains.select { |train| train.type == type }.size
  end
end
