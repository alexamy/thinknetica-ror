# Validation module
module Validation
  def self.extended(base)
    base.class_eval do
      instance_variable_set(:@validations, [])
      add_validate
      add_valid
    end
  end

  def validate(name, type, *args)
    raise 'Validation already presented' if validation_exist?(name, type)
    raise 'Unknown validator' unless allowed_validators.include?(type)

    @validations << [name, type, args.first]
    puts 'add validator'
  end

  protected

  def allowed_validators
    %i[presence format type]
  end

  def validation_exist?(name, type)
    validator = @validations.find do |opts|
      opts[:attr] == name && opts[:type] == type
    end
    !!validator
  end

  def validate_presence
  end

  def validate_format
  end

  def validate_type
  end

  def add_validate
    define_method :validate! do
      puts 'validate!'
    end
  end

  def add_valid
    define_method :valid? do
      puts 'valid?'
    end
  end
end
