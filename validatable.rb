# frozen_string_literal: true

# The Validatable module provides a mechanism for objects to be validated.
# It defines a method to check if an object is valid according to its validation rules.
module Validatable
  def valid?
    validate!
    true
  rescue StandardError
    false
  end
end
