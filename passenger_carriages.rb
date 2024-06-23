# frozen_string_literal: true

# Class representing a passenger carriage
class PassengerCarriage
  # Include the Manufacturer module to add manufacturer-related functionality
  include Manufacturer

  # Define getter and setter methods for total_seats and occupied_seats attributes
  attr_accessor :total_seats, :occupied_seats

  # Initialize a new PassengerCarriage object with a specified total number of seats
  # Set the initial occupied seats to 0
  def initialize(total_seats)
    @type = :passanger_carriage
    @total_seats = total_seats
    @occupied_seats = 0
  end

  # Method to occupy a seat in the passenger carriage
  # Only occupies a seat if there are free seats available
  def occupy_seat
    if @occupied_seats < @total_seats
      @occupied_seats += 1
    else
      puts "All seats are occupied"
    end
  end

  # Method to return the current number of occupied seats
  def occupied_seats_count
    @occupied_seats
  end

  # Method to return the current number of free seats
  def free_seats_count
    @total_seats - @occupied_seats
  end
end
