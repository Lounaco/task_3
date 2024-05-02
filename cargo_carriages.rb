# require_relative 'train'
# require_relative 'cargo_train'
# require_relative 'main'

class CargoCarriage
  attr_accessor :type
  
  def initialize
    @type = :cargo_carriage
  end
end