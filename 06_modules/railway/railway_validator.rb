# Various validators for all modules
module RailwayValidator
  protected

  def trains_validator
    {
      success: trains.any?,
      message: 'Add train first'
    }
  end

  def stations_validator
    {
      success: stations.any?,
      message: 'Add station first'
    }
  end

  def routes_validator
    {
      success: routes.any?,
      message: 'Add route first'
    }
  end

  def stations_for_route_validator
    {
      success: stations.size >= 2,
      message: 'Add at least 2 stations'
    }
  end

  def validate(key)
    validator = "#{key}_validator"
    return unless self.class.method_defined?(validator)

    validate!(validator)
  end

  def validate!(validator)
    validation = send(validator)
    success = validation[:success]
    puts validation[:message] unless success
    success
  end
end
