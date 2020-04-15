class Car
  def initialize
    @speed = 10
    beep
    current_speed
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

  def current_speed
    puts "Current speed: #{@speed}"
  end
end

car = Car.new
puts "new car id: #{car.object_id}"

car.current_speed
car.go
car.current_speed
car.stop
car.current_speed
