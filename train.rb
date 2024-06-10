require_relative 'manufacturer'
require_relative 'instance_counter'

class Train
  include Manufacturer
  include InstanceCounter

  attr_reader :number, :type, :carriages, :current_speed, :current_station

  @@trains = []

  def self.find(number)
    @@trains.find { |train| train.number == number }
  end

  def initialize(number, type)
    @number = number
    @type = type
    @carriages = []
    @current_speed = 0
    @current_station_index = nil
    validate!
    @@trains << self
  end
	
  def speed_up(number)
    @current_speed += number if number.positive?
  end

  def brake(number)
    @current_speed -= number until @current_speed <= 0
    @current_speed = 0
  end

  def add_carriage(carriage)
    if @current_speed.zero? && !@carriages.include?(carriage)
      if (self.is_a?(PassengerTrain) && carriage.is_a?(PassengerCarriage)) || (self.is_a?(CargoTrain) && carriage.is_a?(CargoCarriage))
        @carriages << carriage
      end
    end
  end

  def remove_carriage
    @carriages.pop if @current_speed.zero? && !@carriages.empty?
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


  def valid?
    validate!
    true
  rescue
    false
  end

  private

  def validate!
    raise 'Number cannot be nil' if @number.nil?
    raise 'Type cannot be nil' if @type.nil?
    raise 'Number has invalid format' unless @number =~ /^[a-zA-Z0-9]{3}-?[a-zA-Z0-9]{2}$/i
    raise 'Type is invalid' unless ['passenger', 'cargo'].include?(@type)
  end
end