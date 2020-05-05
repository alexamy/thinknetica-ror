# Validation module
module Validation
  def self.extended(base)
    base.class_eval do
      add_validate
      add_valid
    end
  end

  def validate(attr, type, *args)
    puts 'add validator'
  end

  protected

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
