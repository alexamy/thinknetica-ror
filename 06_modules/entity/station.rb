# Station belongs to route and can add and departure trains
class Station
  class << self
    def all
      @all ||= []
    end
  end

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
    self.class.all << self
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

  def to_s
    "Station #{name} with #{trains.size} trains"
  end

  protected

  attr_writer :name, :trains
end
