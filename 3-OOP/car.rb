class Car
  attr_reader :engine_volume
  # attr_accessor :speed

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
    @speed = 0
  end

  def go
    @speed = 50
  end

  # attr_reader :speed
  def speed
    @speed
  end

  # attr_writer :speed
  def speed=(speed)
    @speed = speed
  end
end

car = Car.new
puts car.speed
puts car.engine_volume
car.speed = 20
puts car.speed
