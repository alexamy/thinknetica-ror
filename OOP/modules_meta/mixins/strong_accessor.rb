module Accessors
  # Add accessor with type check
  module StrongAccessor
    def strong_attr_accessor(key, type)
      raise 'Unknown class' unless type.instance_of?(Class)

      names = { get: key, set: "#{key}=", var: "@#{key}" }
      define_method(names[:get]) { instance_variable_get(names[:var]) }
      define_method(names[:set]) do |value|
        raise 'Wrong value type' unless value.class == type

        instance_variable_set(names[:var], value)
      end
    end
  end
end
