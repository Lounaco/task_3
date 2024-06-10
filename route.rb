class Route
  include InstanceCounter
  
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

  def valid?
    validate!
    true
  rescue
    false
  end

  private

  def validate!
    raise 'Start station cannot be nil' if @start_station.nil?
    raise 'End station cannot be nil' if @end_station.nil?
    raise 'Start and end stations must be different' if @start_station == @end_station
  end
  
end


