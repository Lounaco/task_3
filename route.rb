# require_relative 'train'
# require_relative 'station'

class Route
  attr_reader :stations
	
  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
  end

  def add_station(station) 
    @stations.insert(-2, station)
  end

  def remove_station(station)
    if station != @stations.first && station != @stations.last
      @stations.delete(station)
    end
  end	

  def show_stations
    puts "Stations on the route:"
    @station.each { |station| puts station.name }
  end
end