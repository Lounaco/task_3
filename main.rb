require_relative 'station'
require_relative 'train'
require_relative 'route'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_carriages'
require_relative 'cargo_carriages'

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

    case type
    when 1
      @trains << PassengerTrain.new(number, type)
      puts "Passenger train #{number} has been created."
    when 2
      @trains << CargoTrain.new(number, type)
      puts "Cargo train #{number} has been created."
    else
      puts "Invalid train type."
    end
  end

  def create_route
    puts "Enter the name of the starting station:"
    start_station_name = gets.chomp
    start_station = @stations.find { |station| station.name.casecmp(start_station_name).zero? }

    puts "Enter the name of the ending station:"
    end_station_name = gets.chomp
    end_station = @stations.find { |station| station.name.casecmp(end_station_name).zero? }

    puts "All stations:"
    @stations.each { |station| puts station.name }

    if start_station && end_station
      if start_station != end_station
        @routes << Route.new(start_station, end_station)
        puts "Route from #{start_station.name} to #{end_station.name} has been created."
      else
        puts "Starting and ending stations cannot be the same."
      end
    else
      puts "Station not found."
      # puts "All stations:"
      # @stations.each { |station| puts station.name }
    end
  end


  def manage_route
    puts "Choose a route:"
    @routes.each_with_index {|route, index| puts "#{index +1}. #{route}" }
    route_index = gets.chomp.to_i - 1
    selected_route = @routes[route_index]

    puts "Choose an action (1 - Add station, 2 - Remove station):"
    action = gets.chomp.to_i

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

  # меня терзают смутные сомненья, я бы поставила протектед, но здесь уже прописаны все настройки по пассажирскому/грузовому 
  def add_carriage_to_train
    puts "Choose a train to add a carriage:"
    @trains.each_with_index { |train, index| puts "#{index + 1}. #{train}" }
    train_index = gets.chomp.to_i - 1
    selected_train = @trains[train_index]

    if selected_train.is_a?(PassengerTrain)
      selected_train.add_carriage(PassengerCarriage.new)
    elsif selected_train.is_a?(CargoTrain)
      selected_train.add_carriage(CargoCarriage.new)
    else
      puts "Invalid train type."
    end
  end

  def remove_carriage_from_train
    puts "Choose a train to remove a carriage from:"
    @trains.each_with_index { |train, index| puts "#{index + 1}. #{train}" }
    train_index = gets.chomp.to_i - 1
    selected_train = @trains[train_index]
    selected_train.remove_carriage
  end

protected
# Ниже-методы перемещения поезда должны быть защищены, так как нечего там лазить извне, но можно в в подклассах (пассажирский и грузовой поезда)

  def move_train_forward
    puts "Choose a train to move forward:"
    @trains.each_with_index { |train, index| puts "#{index + 1}. #{train}" }
    train_index = gets.chomp.to_i - 1
    selected_train = @trains[train_index]
    selected_train.move_forward
  end

  def move_train_backward
    puts "Choose a train to move backward:"
    @trains.each_with_index { |train, index| puts "#{index + 1}. #{train}" }
    train_index = gets.chomp.to_i - 1
    selected_train = @trains[train_index]
  
    if selected_train.is_a?(Train)
      selected_train.move_backward
  else
    puts "Selected object is not a Train."
    end
  end

  def display_stations_and_trains
    @stations.each do |station|
      puts "Station: #{station.name}"
      puts "Trains at the station:"
      station.trains.each { |train| puts "- #{train}" }
      puts ""
    end
  end

public
# Ниже-публичный метод, запускает основной цикл программы.

  def start_program
    loop do
      puts "Choose an option:"
      puts "1. Create a station"
      puts "2. Create a train"
      puts "3. Create a route"
      puts "4. Manage stations in a route"
      puts "5. Assign a route to a train"
      puts "6. Add a carriage to a train"
      puts "7. Remove a carriage from a train"
      puts "8. Move a train forward"
      puts "9. Move a train backward"
      puts "10. Display stations and trains"
      puts "11. Exit"

      choice = gets.chomp.to_i

      case choice
      when 1 then create_station
      when 2 then create_train
      when 3 then create_route
      when 4 then manage_route
      when 5 then assign_route_to_train
      when 6 then add_carriage_to_train
      when 7 then remove_carriage_from_train
      when 8 then move_train_forward
      when 9 then move_train_backward
      when 10 then display_stations_and_trains
      when 11 then break
      else
        puts "Invalid choice. Please try again."
      end
    end
  end
end

main_program = Main.new
main_program.start_program