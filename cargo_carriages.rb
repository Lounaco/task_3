
class CargoCarriage
  include Manufacturer
  
  attr_accessor :type
  
  def initialize
    @type = :cargo_carriage
  end
end