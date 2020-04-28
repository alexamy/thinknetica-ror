# Add counting instances of class
module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  # Instance methods
  module InstanceMethods
    def register_instance
      self.class.instances << self
    end
  end

  # Class methods
  module ClassMethods
    def instances
      @instances ||= []
    end
  end
end
