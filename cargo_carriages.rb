
class CargoCarriage
  include Manufacturer
  
  attr_accessor :type, total_volume, :occupied_volume
  
  def initialize(total_volume)
    @type = :cargo_carriage
    @total_volume = total_volume
    @occupied_volume = 0
  end

  def occupy_volume(volume)
    if @occupied_volume + volume <= @total_volume
      @occupied_volume += volume
    else
      puts "Not enough avaliable volume."
    end
  end

  def occupied_volume_count
      @occupied_volume
  end

  def free_volume_count
    @total_volume - @occupied_volume
  end  

end