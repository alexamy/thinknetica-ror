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
    validate!("#{key}_validator")
    true
  rescue NoMethodError
    raise
  rescue StandardError => e
    puts e.message
    false
  end

  def validate!(validator)
    validation = send(validator)
    raise validation[:message] unless validation[:success]
  end
end
