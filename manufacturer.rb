module Manufacturer
  attr_accessor :manufacturer

  def set_manufacturer(name)
    self.manufacturer = name
  end

  def get_manufacturer
    self.manufacturer
  end
end
