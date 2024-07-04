# frozen_string_literal: true

require_relative 'validation'

# Class representing a route consisting of multiple stations
class Route
  include InstanceCounter
  include Validation

  attr_reader :stations

  validate :name, :presence
  validate :name, :format, /\A[A-Z][a-zA-Z0-9\s]*\z/
  validate :name, :type, String

  # Initializes a new route with a start and end station
  # Validates the route upon creation
  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    validate!
  end

  # Adds a station to the route between the start and end stations
  def add_station(station)
    @stations.insert(-2, station)
  end

  # Removes a station from the route, ensuring it is not the start or end station
  def remove_station(station)
    return unless station != @stations.first && station != @stations.last

    @stations.delete(station)
  end

  private

  # Validates the route's stations
  def validate!
    raise 'Start and end stations must be different' if @stations.first == @stations.last
  end
end
