# frozen_string_literal: true

require_relative 'station'
require_relative 'train'
require_relative 'route'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_carriages'
require_relative 'cargo_carriages'
require_relative 'validation'
require_relative 'accessors'

# Main class to handle the railway system operations
class Main
  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  # Method to create a new station
  def create_station
    puts 'Enter the name of the station'
    name = gets.chomp
    raise 'Station name cannot be empty.' if name.empty?

    station = Station.new(name)
    @stations << station
    puts "Station #{name} has been created."
  rescue StandardError => e
    puts "Error: #{e.message}"
    retry
  end

  # Method to create a new train
   def create_train
    begin
      puts 'Enter the number of the train:'
      number = gets.chomp
      raise 'Train number is invalid. It should be in format XXX-XX.' unless number.match?(/^\w{3}-?\w{2}$/)
    rescue StandardError => e
      puts "Error: #{e.message}"
      retry
    end

    puts 'Choose the type of the train (1-Passenger, 2-Cargo):'
    type = gets.chomp.to_i
    raise 'Invalid train type.' unless [1, 2].include?(type)

    begin
      case type
      when 1
        @trains << PassengerTrain.new(number, 'passenger')
        puts "Passenger train #{number} has been created."
      when 2
        @trains << CargoTrain.new(number, 'cargo')
        puts "Cargo train #{number} has been created."
      end
    rescue StandardError => e
      puts "Error: #{e.message}"
      retry
    end
  end

  # Method to create a new route
  def create_route
    puts 'Enter the name of the starting station:'
    start_station_name = gets.chomp.downcase
    start_station = @stations.find { |station| station.name.downcase == start_station_name }
    raise 'Starting station not found.' if start_station.nil?

    puts 'Enter the name of the ending station:'
    end_station_name = gets.chomp.downcase
    end_station = @stations.find { |station| station.name.downcase == end_station_name }
    raise 'Ending station not found.' if end_station.nil?

    raise 'Starting and ending stations cannot be the same.' if start_station == end_station

    @routes << Route.new(start_station, end_station)
    puts "Route from #{start_station.name} to #{end_station.name} has been created."
  rescue StandardError => e
    puts "Error: #{e.message}"
    retry
  end

  # Method to manage stations within a route
  def manage_route
    puts 'Choose a route:'
    @routes.each_with_index { |route, index| puts "#{index + 1}. #{route.stations.map(&:name).join(' -> ')}" }
    route_index = gets.chomp.to_i - 1
    raise 'Invalid route selection.' unless route_index.between?(0, @routes.length - 1)

    selected_route = @routes[route_index]

    puts 'Choose an action (1 - Add station, 2 - Remove station):'
    action = gets.chomp.to_i
    raise 'Invalid action selection.' unless [1, 2].include?(action)

    case action
    when 1
      puts 'Enter the name of the station to add:'
      station_name = gets.chomp
      station = @stations.find { |station| station.name == station_name }
      raise 'Station not found.' if station.nil?

      selected_route.add_station(station)
      puts "#{station_name} added to the route."
    when 2
      puts 'Enter the name of the station to remove:'
      station_name = gets.chomp
      selected_route.remove_station(station_name)
      puts "#{station_name} removed from the route."
    end
  rescue StandardError => e
    puts "Error: #{e.message}"
    retry
  end

  # Method to assign a route to a train
  def assign_route_to_train
    puts 'Choose a train to assign a route:'
    @trains.each_with_index { |train, index| puts "#{index + 1}. #{train.number}" }
    train_index = gets.chomp.to_i - 1
    raise 'Invalid train selection.' unless train_index.between?(0, @trains.length - 1)

    selected_train = @trains[train_index]

    puts 'Choose a route to assign to the train:'
    @routes.each_with_index { |route, index| puts "#{index + 1}. #{route.stations.map(&:name).join(' -> ')}" }
    route_index = gets.chomp.to_i - 1
    raise 'Invalid route selection.' unless route_index.between?(0, @routes.length - 1)

    selected_route = @routes[route_index]
    selected_train.assign_route(selected_route)
    puts "Route assigned to train #{selected_train.number}."
  rescue StandardError => e
    puts "Error: #{e.message}"
    retry
  end

  # Method to add a carriage to a train
  def add_carriage_to_train
    puts 'Choose a train to add a carriage:'
    @trains.each_with_index { |train, index| puts "#{index + 1}. #{train.number}" }
    train_index = gets.chomp.to_i - 1
    raise 'Invalid train selection.' unless train_index.between?(0, @trains.length - 1)

    selected_train = @trains[train_index]

    if selected_train.is_a?(PassengerTrain)
      puts 'Enter the number of seats in the passenger carriage:'
      seats = gets.chomp.to_i
      selected_train.add_carriage(PassengerCarriage.new(seats))
      puts "Passenger carriage with #{seats} seats added."
    elsif selected_train.is_a?(CargoTrain)
      puts 'Enter the total volume of the cargo carriage:'
      volume = gets.chomp.to_i
      selected_train.add_carriage(CargoCarriage.new(volume))
      puts "Cargo carriage with #{volume} volume added."
    else
      raise 'Invalid train type.'
    end
  rescue StandardError => e
    puts "Error: #{e.message}"
    retry
  end

  # Method to remove a carriage from a train
  def remove_carriage_from_train
    puts 'Choose a train to remove a carriage from:'
    @trains.each_with_index { |train, index| puts "#{index + 1}. #{train.number}" }
    train_index = gets.chomp.to_i - 1
    raise 'Invalid train selection.' unless train_index.between?(0, @trains.length - 1)

    selected_train = @trains[train_index]
    selected_train.remove_carriage
    puts 'Carriage removed.'
  rescue StandardError => e
    puts "Error: #{e.message}"
    retry
  end

  # Method to occupy a seat or volume in a carriage
  def occupy_seat_or_volume
    if @trains.empty?
      puts 'No trains available.'
      return
    end

    puts 'Choose a train to occupy seat or volume:'
    @trains.each_with_index { |train, index| puts "#{index + 1}. #{train.number}" }
    train_index = gets.chomp.to_i - 1

    raise 'Invalid train selection.' if train_index.negative? || train_index >= @trains.length

    selected_train = @trains[train_index]

    if selected_train.carriages.empty?
      puts 'Selected train has no carriages.'
      return
    end

    puts 'Choose a carriage number:'
    selected_train.carriages.each_with_index do |carriage, index|
      if carriage.is_a?(PassengerCarriage)
        puts "#{index + 1}. Carriage type: Passenger, Free seats: #{carriage.free_seats_count}"
      elsif carriage.is_a?(CargoCarriage)
        puts "#{index + 1}. Carriage type: Cargo, Free volume: #{carriage.free_volume_count}"
      end
    end

    carriage_index = gets.chomp.to_i - 1

    raise 'Invalid carriage selection.' if carriage_index.negative? || carriage_index >= selected_train.carriages.length

    selected_carriage = selected_train.carriages[carriage_index]

    if selected_carriage.is_a?(PassengerCarriage)
      selected_carriage.occupy_seat
      puts "Seat occupied. Free seats: #{selected_carriage.free_seats_count}"
    elsif selected_carriage.is_a?(CargoCarriage)
      puts 'Enter the volume to occupy:'
      volume = gets.chomp.to_i
      selected_carriage.occupy_volume(volume)
      puts "Volume occupied. Free volume: #{selected_carriage.free_volume_count}"
    else
      raise 'Invalid carriage type.'
    end
  rescue StandardError => e
    puts "Error: #{e.message}"
    retry
  end

  # Display history of attributes for a train
  def display_train_history(number)
      train = Train.find(number)
      if train
        puts "Train #{train.number} history:"
        puts "Number: #{train.number_history}"
        puts "Type: #{train.type_history}" if train.respond_to?(:type_history)
        puts "Speed: #{train.speed_history}" if train.respond_to?(:speed_history)
      else
        puts "Train with number #{number} not found."
      end
    end

  protected

  # Methods to move train should be protected

  # Method to move a train forward
  def move_train_forward
    puts 'Choose a train to move forward:'
    @trains.each_with_index { |train, index| puts "#{index + 1}. #{train.number}" }
    train_index = gets.chomp.to_i - 1
    raise 'Invalid train selection.' unless train_index.between?(0, @trains.length - 1)

    selected_train = @trains[train_index]
    selected_train.move_forward
    puts 'Train moved forward.'
  rescue StandardError => e
    puts "Error: #{e.message}"
    retry
  end

  # Method to move a train backward
  def move_train_backward
    puts 'Choose a train to move backward:'
    @trains.each_with_index { |train, index| puts "#{index + 1}. #{train.number}" }
    train_index = gets.chomp.to_i - 1
    raise 'Invalid train selection.' unless train_index.between?(0, @trains.length - 1)

    selected_train = @trains[train_index]
    selected_train.move_backward
    puts 'Train moved backward.'
  rescue StandardError => e
    puts "Error: #{e.message}"
    retry
  end

  # Method to display all stations and their trains
  def display_stations_and_trains
    @stations.each do |station|
      puts "Station: #{station.name}"
      puts 'Trains at the station:'
      station.trains.each do |train|
        puts "- #{train.number} (#{train.class.name}), Carriages: #{train.carriages.length}"
        train.carriages.each_with_index do |carriage, index|
          if carriage.is_a?(PassengerCarriage)
            puts "Carriage #{index + 1}: Passenger, Free seats: #{carriage.free_seats_count}, Occupied seats: #{carriage.occupied_seats}"
          elsif carriage.is_a?(CargoCarriage)
            puts "Carriage #{index + 1}: Cargo, Free volume: #{carriage.free_volume_count}, Occupied volume: #{carriage.occupied_volume}"
          end
        end
      end
      puts ''
    end
  end

  public

  # Main method to start the program and display the menu options
  def start_program
    loop do
      puts 'Choose an option:'
      puts '1. Create a station'
      puts '2. Create a train'
      puts '3. Create a route'
      puts '4. Manage stations in a route'
      puts '5. Assign a route to a train'
      puts '6. Add a carriage to a train'
      puts '7. Remove a carriage from a train'
      puts '8. Move a train forward'
      puts '9. Move a train backward'
      puts '10. Display stations and trains'
      puts '11. Occupy seat or volume in a carriage'
      puts '12. Display history of attributes for a train'
      puts '13. Exit'

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
      when 11 then occupy_seat_or_volume
      when 12 
        puts 'Enter the number of the train to display history:'
        train_number = gets.chomp
        display_train_history(train_number)
      when 13 then break
      else
        puts 'Invalid choice. Please try again.'
      end
    end
  end
end

# Instantiate and start the main program
main_program = Main.new
main_program.start_program
