# frozen_string_literal: true

require_relative 'validatable'

class Route
  include InstanceCounter
  include Validatable
  
  attr_reader :stations
	
  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    validate!
  end

  def add_station(station) 
    @stations.insert(-2, station)
  end

  def remove_station(station)
    if station != @stations.first && station != @stations.last
      @stations.delete(station)
    end
  end	

  private

  def validate!
    raise 'Start station cannot be nil' if @stations.first.nil?
    raise 'End station cannot be nil' if @stations.last.nil?
    raise 'Start and end stations must be different' if @stations.first == @stations.last
  end
end
