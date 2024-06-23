# frozen_string_literal: true

# The InstanceCounter module provides functionality for tracking the number of class instances.
module InstanceCounter
  # Called when the module is included in a class
  def self.included(base)
    # Extends the class with ClassMethods
    base.extend ClassMethods
    # Includes InstanceMethods into the class
    base.include InstanceMethods

    # Initializes the class instance counter to 0
    base.instance_variable_set('@instances', 0)
  end

  # Module for class-level methods
  module ClassMethods
    # Returns the number of instances of the class
    def instances
      @instances
    end

    # Increases the class instance counter by 1
    def increase_instance_counter
      @instances += 1
    end
  end

  # Module for instance-level methods
  module InstanceMethods
    # Registers a new instance of the class
    # Increases the class instance counter
    def register_instance
      self.class.increase_instance_counter
    end
  end
end
