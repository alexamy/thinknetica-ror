module Validation
  # Validators for validation module
  module Validator
    class << self
      def presence(value, _)
        raise 'Value is nil or empty string!' if value.nil? || value.to_s.empty?
      end

      def format(value, regexp)
        raise 'Bad format for value!' unless value.to_s =~ regexp
      end

      def type(value, type)
        raise 'Bad value type!' unless value.instance_of?(type)
      end
    end
  end
end
