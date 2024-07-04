# frozen_string_literal: true

require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'validation'
require_relative 'accessors'

# Class representing a train
class Train
  include Manufacturer
  include InstanceCounter
  include Validation
  extend Accessors

  attr_accessor_with_history :number, :speed
  strong_attr_accessor :type, String

  attr_reader :carriages, :current_speed, :current_station

  @@trains = []

  validate :number, :presence
  validate :name, :format, /\A[A-Z][a-zA-Z0-9\s]*\z/

  # Class method to find a train by its number
  def self.find(number)
    @@trains.find { |train| train.number == number }
  end

  # Initializes a new train with a number and type
  # Validates the train upon creation
  def initialize(number, type)
    @number = number
    @type = type
    @carriages = []
    @current_speed = 0
    @current_station_index = nil
    @@trains << self
    validate!
  end

  # Increases the train's speed by the given number
  def speed_up(number)
    @current_speed += number if number.positive?
  end

  # Reduces the train's speed by the given number until it stops
  def brake(number)
    @current_speed -= number until @current_speed <= 0
    @current_speed = 0
  end

  # Adds a carriage to the train if it is stopped and the carriage type matches the train type
  def add_carriage(carriage)
    return unless @current_speed.zero? && !@carriages.include?(carriage) && ((is_a?(PassengerTrain) && carriage.is_a?(PassengerCarriage)) || (is_a?(CargoTrain) && carriage.is_a?(CargoCarriage)))
        @carriages << carriage
  end

  # Removes the last carriage from the train if it is stopped
  def remove_carriage
    @carriages.pop if @current_speed.zero? && !@carriages.empty?
  end

  # Assigns a route to the train and sets its current station to the starting station of the route
  def assign_route(route)
    @route = route
    @current_station_index = 0
    @current_station = @route.stations[@current_station_index]
    @current_station.arrive_train(self)
  end

  # Moves the train forward to the next station on the route
  def move_forward
    return unless @route && @current_station_index < @route.stations.size - 1

    @current_station.depart_train(self)
    @current_station_index += 1
    @current_station = @route.stations[@current_station_index]
    @current_station.arrive_train(self)
  end

  # Moves the train backward to the previous station on the route
  def move_backward
    return unless @route && @current_station_index > 0

    @current_station.depart_train(self)
    @current_station_index -= 1
    @current_station = @route.stations[@current_station_index]
    @current_station.arrive_train(self)
  end

  # Iterates over each carriage in the train, yielding to the given block
  def each_carriage(&block)
    @carriages.each(&block) if block_given?
  end

  private

  # Returns the current station of the train
  def current_station
    @route.stations[@current_station_index] if @route
  end

  # Returns the next station on the route, if there is one
  def next_station
    @route.stations[@current_station_index + 1] if @route && @current_station_index < @route.stations.size - 1
  end

  # Returns the previous station on the route, if there is one
  def previous_station
    @route.stations[@current_station_index - 1] if @route && @current_station_index > 0
  end

end
