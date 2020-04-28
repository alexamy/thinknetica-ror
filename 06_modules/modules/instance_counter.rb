# Add counting instances of class
module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  # Instance methods
  module InstanceMethods
    protected

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
