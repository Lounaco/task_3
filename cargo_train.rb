require_relative 'train'

class CargoTrain < Train
  def initialize
    super
    @type = :Cargo
  end
end