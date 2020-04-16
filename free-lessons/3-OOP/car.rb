class Car
  attr_reader :engine_volume
  attr_accessor :speed

  def initialize(speed = 0, engine_volume = 1.6)
    @speed = speed
    @engine_volume = engine_volume
  end

  def start_engine
    puts "wroom!"
  end

  def beep
    puts "beep beep"
  end

  def stop
    self.speed = 0
  end

  def go
    self.speed = 50
  end
end

car = Car.new
puts car.speed
puts car.engine_volume
car.speed = 20
puts car.speed
