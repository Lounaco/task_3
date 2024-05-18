# require_relative 'train'
# require_relative 'route'
# require_relative 'cargo_train'
# require_relative 'passenger_train'

class Station
  include InstanceCounter
  @@stations = []

  def self.all
    @@stations
  end  

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
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
end



 


