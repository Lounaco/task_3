# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validatable'

# Class representing a train station
class Station
  include InstanceCounter
  include Validatable

  # Class variable to hold all station instances
  @@stations = []

  # Class method to return all station instances
  def self.all
    @@stations
  end

  attr_reader :name, :trains

  # Initializes a new station with a name
  # Validates the station upon creation and adds it to the list of all stations
  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
  end

  # Adds a train to the station's list of trains
  def arrive_train(train)
    @trains << train
  end

  # Returns all trains currently at the station
  def all_trains
    @trains
  end

  # Returns all trains of a specific type currently at the station
  def trains_by_type(type)
    @trains.select { |train| train.type == type }
  end

  # Removes a train from the station's list of trains
  def depart_train(train)
    @trains.delete(train)
  end

  # Iterates over each train at the station, yielding to the given block
  def each_train
    @trains.each { |train| yield(train) }
  end
  
  private

  # Validates the station's name
  def validate!
    raise "Name cannot be nil" if @name.nil?
    raise "Name must be at least 3 characters long" if @name.length < 3
  end
end
