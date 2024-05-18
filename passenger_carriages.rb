# require_relative 'train'
# require_relative 'passenger_train'
# require_relative 'main'

class PassengerCarriage
  include Manufacturer
  
  attr_accessor :type
  
  def initialize
    @type = :passanger_carriage
  end
end