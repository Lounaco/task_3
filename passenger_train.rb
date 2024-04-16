require_relative 'train.rb'

class PassangerTrain < Train
  def initialize
    super
    @type = :Passanger
  end
end