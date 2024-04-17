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

  def create_route
    puts "Enter the name of the starting station:"
    start_station_name = gets.chomp
    start_station = @stations.find {|station| station.name == start_station_name}

    puts "Enter the name of the ending station:"
    end_station_name = gets.chomp
    end_station = @stations.find {|station| station.name == end_station_name}

    if start_station && end_station_name
      @routes << Route.new(start_station, end_station)
      puts "Route from #{start_station_name} to #{end_station_name} has been created."
    else
      puts "Station not found."
    end
  end

  def manage_route
    puts "Choose a route:"
    @routes.each_with_index {|route, index| puts "#{index +1}. #{route}" }
    route_index = gets.chomp.to_i - 1
    selected_route = @routes[route_index]

    puts "Choose an action (1 - Add station, 2 - Remove station):"
    action = gets.chomp/.to_i

    if action == 1
      puts "Enter the name of the station to add:"
      station_name = gets.chomp
      station = @stations.find {|station| station.name == station_name}
      selected_route.add_station(station) if station
    elsif action == 2
      puts "Enter the name of the station to remove:"
      station_name = gets.chomp
      selected_route.remove_station(station_name)
    else
      puts "Invalid action."
    end
  end

  def assing_route_to_train
    puts "Choose a train to assign a route:"
    @trains.each_with_index {|train, index| puts "#{index + 1}. #{train}" }
    train_index = gets.chomp.to_i - 1
    selected_train = @trains[train_index]
    
    puts "Choose a route to assign to the train:"
    @routes.each_with_index { |route, index| puts "#{index + 1}. #{route}" }
    route_index = gets.chomp.to_i - 1
    selected_route = @routes[route_index]

    selected_train.assign_route(selected_route)
  end

  def add_carriage_to_train
  end