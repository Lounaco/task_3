# frozen_string_literal: true

class PassengerCarriage
  include Manufacturer
  
  attr_accessor :total_seats, :occupied_seats
  
  def initialize(total_seats)
    @type = :passanger_carriage
    @total_seats = total_seats
    @occupied_seats = 0
  end

  def occupy_seat
    if @occupied_seats < @total_seats
      @occupied_seats += 1
    else
      puts 'All seats are occupied'
    end
  end

  def occupied_seats_count
    @occupied_seats
  end
  
  def free_seats_count
    @total_seats - @occupied_seats
  end
end
