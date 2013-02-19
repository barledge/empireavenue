require 'empireavenue/error'

module EmpireAvenue
  class Error
    # Raised when JSON parsing fails
    class DecodeError < EmpireAvenue::Error
    end
  end
end