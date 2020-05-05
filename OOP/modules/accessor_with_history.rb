# Accessor with values history
module AccessorWithHistory
  def attr_accessor_with_history(*keys)
    keys.each { |key| add_accessor(key) }
  end

  protected

  def add_accessor(key)
    names = {
      get: key,
      set: "#{key}=",
      var: "@#{key}",
      history_get: "#{key}_history",
      history_add: "#{key}_history_add",
      history_var: "@#{key}_history"
    }
    add_get_set(names)
    add_history(names)
  end

  def add_get_set(names)
    define_method(names[:get]) { instance_variable_get(names[:var]) }

    define_method(names[:set]) do |value|
      instance_variable_set(names[:var], value)
      send(names[:history_add], value)
    end

    define_method(names[:history_get]) do
      instance_variable_get(names[:history_var])
    end
  end

  def add_history(names)
    define_method(names[:history_add]) do |value|
      history = instance_variable_get(names[:history_var])
      instance_variable_set(names[:history_var], []) unless history
      instance_variable_get(names[:history_var]) << value
    end

    protected names[:history_add]
  end
end
