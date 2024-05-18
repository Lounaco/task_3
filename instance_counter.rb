module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods

    base.instance_variable_set("@instances", 0)
  end

  module ClassMethods
    def instances
      @instances
    end

    def increase_instance_counter
      @instances ||= 0
      @instances += 1
    end
  end

  module InstanceMethods
    private

    def register_instance
      self.class.increase_instance_counter
    end
  end
end