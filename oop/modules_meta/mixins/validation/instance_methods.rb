module Validation
  # Validation instance methods
  module InstanceMethods
    def validate!
      validations = self.class.instance_variable_get(:@validations)
      validations.each do |name:, type:, args:|
        var = instance_variable_get(name)
        Validation::Validator.send(type, var, args.first)
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end
  end
end
