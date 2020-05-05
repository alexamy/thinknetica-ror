# Validation module
module Validation
  def self.extended(base)
    base.include(InstanceMethods)
    base.class_eval { instance_variable_set(:@validations, []) }
  end

  def validate(name_sym, type, *args)
    name = "@#{name_sym}"

    raise 'Validation already presented!' if validation_exist?(name, type)
    raise 'Unknown validator!' unless allowed_validators.include?(type)

    @validations << { name: name, type: type, args: args }
  end

  module InstanceMethods
    def validate!
      validations = self.class.instance_variable_get(:@validations)
      validations.each do |name:, type:, args:|
        var = instance_variable_get(name)
        func = "validate_#{type}"
        self.class.send(func, var, args.first)
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end
  end

  protected

  def allowed_validators
    %i[presence format type]
  end

  def validation_exist?(name, type)
    validator = @validations.find do |opts|
      opts[:name] == name && opts[:type] == type
    end
    !!validator
  end

  def validate_presence(value, _)
    raise 'Value is nil or empty string!' if value.nil? || value.to_s.empty?
  end

  def validate_format(value, regexp)
    raise 'Bad format for value!' unless value.to_s =~ regexp
  end

  def validate_type(value, type)
    raise 'Bad value type!' unless value.instance_of?(type)
  end
end
