# frozen_string_literal: true

require_relative 'train'

# The CargoTrain class is a freight train.
class CargoTrain < Train
  def initialize(number, type)
    super(number, type)
    @type = :Cargo
  end
end
