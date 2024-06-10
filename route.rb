class Route
  include InstanceCounter
  
  attr_reader :stations
	
  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    validate_data
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

  def valid?
    validate_data
  end

  private

  def validate_data
    raise "Route must have at least two stations"
unless @stations.size >= 2
    raise "Start and end stations must be different"
if @stations.first == @stations.last

    true
  end     
end


