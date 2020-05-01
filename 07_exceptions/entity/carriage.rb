# Carriage for train
class Carriage
  include Manufacturer
end

# Cargo carriage
class CargoCarriage < Carriage
end

# Passenger carriage
class PassengerCarriage < Carriage
end
