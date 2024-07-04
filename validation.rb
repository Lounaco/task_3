# frozen_string_literal: true

# Module for adding validation functionality to classes
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  # Class-level methods for validation
  module ClassMethods
    # Define a validation for an attribute
    def validate(attr_name, validation_type, *params)
      @validations ||= []
      @validations << { attribute: attr_name, type: validation_type, options: params }
    end

    # Get all validations defined for the class
    def validations
      @validations ||= []
    end
  end

  # Instance methods for validating attributes
  module InstanceMethods
    # Validate all defined validations for the instance
    def validate!
      self.class.validations.each do |validation|
        attribute_value = instance_variable_get("@#{validation[:attribute]}")
        send("validate_#{validation[:type]}", attribute_value, *validation[:options])
      end
    end

    # Check if the instance is currently valid
    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    private

    # Validate presence of an attribute's value
    def validate_presence(value, *_options)
      raise 'Attribute cannot be nil or empty' if value.nil? || value.to_s.empty?
    end

    # Validate format of an attribute's value
    def validate_format(value, format)
      raise 'Invalid format' unless value =~ format
    end

    # Validate type of an attribute's value
    def validate_type(value, type)
      raise 'Invalid type' unless value.is_a?(type)
    end
  end
end
