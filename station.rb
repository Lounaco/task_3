require_relative 'instance_counter.rb'
require_relative 'validatable'

class Station
  include InstanceCounter
  include Validatable

  @@stations = []

  def self.all
    @@stations
  end  

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
  end

  def arrive_train(train)
    @trains << train
  end

  def all_trains
    @trains
  end

  def trains_by_type(type)
    @trains.select { |train| train.type == type }
  end

  def depart_train(train)
    @trains.delete(train)
  end
  

  private

  def validate!
    raise 'Name cannot be nil' if @name.nil?
    raise 'Name must be at least 3 characters long' if @name.length < 3
  end
end