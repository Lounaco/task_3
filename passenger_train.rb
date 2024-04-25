require_relative 'train'

class PassangerTrain < Train
  def initialize
    super
    @type = :Passanger
  end
end