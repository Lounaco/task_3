# require_relative 'train'
# require_relative 'cargo_train'
# require_relative 'main'

class CargoCarriage
  include Manufacturer
  
  attr_accessor :type
  
  def initialize
    @type = :cargo_carriage
  end
end