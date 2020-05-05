# Carriages code for railway management
module RaiwayCarriages
  def add_carriage_to_train
    train = select_train
    carriage = train.carriage_type
    amount = Ui.get_input("enter #{carriage::SPACE_KEY} amount")
    train.add_carriage(carriage.new(amount))
  end

  def remove_carriage_from_train
    train = select_train
    train.remove_carriage
  end

  def use_space_in_carriage
    train = select_train
    carriages = train.carriages

    raise 'No carriages!' if carriages.empty?

    carriage = Ui.choose_from(carriages)
    occupy_carriage(carriage)
  end

  protected

  def occupy_carriage(carriage)
    key = "occupy_#{carriage.space_key}"
    method = carriage.method(key.to_sym)

    if carriage.class == CargoCarriage
      amount = Ui.get_input('how much space to occupy')
      method.call(amount)
    else
      method.call
    end
  end
end
