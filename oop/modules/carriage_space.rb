# Allow to occupy carriage space
module CarriageSpace
  attr_reader :space, :space_occupied

  def occupy_space(space_add)
    raise 'Added space must be positive!' unless space_add.positive?
    raise 'All space is occupied!' if space_occupied == space

    space_new = space_occupied + space_add
    raise 'Initial space exceeded!' if space_new > space

    self.space_occupied = space_new
  end

  def space_free
    space - space_occupied
  end

  protected

  attr_writer :space, :space_occupied
end
