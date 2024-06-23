# frozen_string_literal: true

# Class representing a cargo carriage
class CargoCarriage
  # Include the Manufacturer module to add manufacturer-related functionality
  include Manufacturer

  # Define getter and setter methods for total_volume and occupied_volume attributes
  attr_accessor :total_volume, :occupied_volume

  # Initialize a new CargoCarriage object with a specified total volume
  # Set the initial occupied volume to 0
  def initialize(total_volume)
    @type = :cargo_carriage
    @total_volume = total_volume
    @occupied_volume = 0
  end

  # Method to occupy a specified volume in the cargo carriage
  # Only occupies the volume if there is enough free space
  def occupy_volume(volume)
    if @occupied_volume + volume <= @total_volume
      @occupied_volume += volume
    else
      puts 'Not enough avaliable volume.'
    end
  end

  # Method to return the current occupied volume
  def occupied_volume_count
    @occupied_volume
  end

  # Method to return the current free volume
  def free_volume_count
    @total_volume - @occupied_volume
  end
end
