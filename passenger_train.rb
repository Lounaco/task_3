# frozen_string_literal: true

require_relative 'train'

# Class representing a passenger train, inheriting from Train
class PassengerTrain < Train
  def initialize(number, type)
    super(number, type)
    @type = :Passenger
  end
end
