# Add counting instances of class
module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  # Instance methods
  module InstanceMethods
    def register_instance
      self.class.pool << self
    end
  end

  # Class methods
  module ClassMethods
    def pool
      @pool ||= []
    end

    def instances
      pool.size
    end
  end
end
