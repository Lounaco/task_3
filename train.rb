lass Train
	attr_reader :number, :type, :carriages, :current_speed, :current_station

	def initialize( number, type, carriages)
		@number = number
		@type = type
		@carriages = carriages
		@current_speed = 0
		@current_station_index = nil
	end
	
	def speed_up(number)
    @current_speed += number
  end

  def brake(number)
    while @current_speed > 0
      @current_speed -= number

      @current_speed = 0 if @current_speed < 0
    end  

  def add_carriage
    @carriages += 1 if @current_speed = 0
  end

  def remove_carriage
    @carriages -= 1 if @current_speed = 0 
  end

  def assign_route(route)
    @route = route
    @current_station_index = 0
    @current_station = @route.stations[@current_station_index]
    @current_station.arrive_train(self)
  end

  def move_forward
    return unless @route && @current_station_index < @route.stations.size - 1

    @current_station.depart_train(self)
    @current_station_index += 1
    @current_station = @route.stations[@current_station_index]
    @current_station.arrive_train(self)
  end

  def move_backward
    return unless @route && @current_station_index > 0

    @current_station.depart_train(self)
    @current_station_index -= 1
    @current_station = @route.stations[@current_station_index]
    @current_station.arrive_train(self)
  end
  
end