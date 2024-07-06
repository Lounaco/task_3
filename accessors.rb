# frozen_string_literal: true

# Module to add extra functionality, such as history tracking and type checking, to attribute accessors in classes
module Accessors
  # Method to define getters, setters, and history tracking for attributes
  def attr_accessor_with_history(*attrs)
    attrs.each do |attr_name|
      attr_name = attr_name.to_sym

      # Getter method
      define_method(attr_name) do
        instance_variable_get("@#{attr_name}")
      end

      # Setter method with history tracking
      define_method("#{attr_name}=") do |value|
        @history ||= {}
        @history[attr_name] ||= []
        @history[attr_name] << instance_variable_get("@#{attr_name}") if instance_variable_defined?("@#{attr_name}")
        instance_variable_set("@#{attr_name}", value)
      end

      # Method to get the history of values for the attribute
      define_method("#{attr_name}_history") do
        @history && @history[attr_name] ? @history[attr_name].compact : []
      end
    end
  end

  # Method to define getter and setter with type checking for an attribute
  def strong_attr_accessor(attr_name, attr_class)
    attr_name = attr_name.to_sym

    # Setter method with type checking
    define_method(attr_name) do
      instance_variable_get("@#{attr_name}")
    end

    # Setter with type checking
    define_method("#{attr_name}=") do |value|
      unless value.is_a?(attr_class)
        raise TypeError, "Expected #{attr_class}, got #{value.class}"
      end
      instance_variable_set("@#{attr_name}", value)
    end
  end
end
