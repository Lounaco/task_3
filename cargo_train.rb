require_relative 'train'

class CargoTrain < Train
  def initialize(number, type)
    super(number)
    @type = :Cargo
  end
end