require_relative 'route.rb'
require_relative 'train.rb'
require_relative 'station.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_train.rb'
require_relative 'passenger_carriage.rb'
require_relative 'cargo_carriage.rb'

class Main
  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def create_station
    puts "Enter the name of the station"
    name = gets.chomp
    @stations<<Station.new(name)
    puts "Station #{name} has been created."
  end

  def create_train
    puts "Enter the number of the train:"
    number = gets.chomp
    puts "Choose the type of the train (1-Pasenger, 2-Cargo):"
    type = gets.chomp.to_i

  if type == 1
    @trains<<PassengerTrain.new(number)
    puts "Passenger train #{number} has been created."
  elsif type == 2
    @trains << CargoTrain.new(number)
    puts "Cargo train #{number} has been created."
  else
    Puts "Invalid train type."
  end
end