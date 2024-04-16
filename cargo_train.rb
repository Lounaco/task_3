require_relative 'train.rb'

class CargoTrain < Train
  def initialize
    super
    @type = :Cargo
  end
end