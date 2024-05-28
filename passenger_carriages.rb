

class PassengerCarriage
  include Manufacturer
  
  attr_accessor :type
  
  def initialize
    @type = :passanger_carriage
  end
end