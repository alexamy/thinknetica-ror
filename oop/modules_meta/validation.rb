# Validation module
module Validation
  def self.extended(base)
    base.include(InstanceMethods)
    base.class_eval { instance_variable_set(:@validations, []) }
  end

  def validate(name_sym, type, *args)
    name = "@#{name_sym}"

    raise 'Validation already presented!' if validation_exist?(name, type)
    raise 'Unknown validator!' unless Validator.methods(false).include?(type)

    @validations << { name: name, type: type, args: args }
  end

  protected

  def validation_exist?(name, type)
    validation = @validations.find do |opts|
      opts[:name] == name && opts[:type] == type
    end
    !!validation
  end
end
