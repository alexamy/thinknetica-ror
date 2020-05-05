# Validator for class initialization
module InitValidator
  def valid?
    validate!
    true
  rescue NoMethodError
    raise
  rescue StandardError
    false
  end

  protected

  def validate!
    raise NoMethodError, "Redefine validate! method in #{self.class}"
  end
end
