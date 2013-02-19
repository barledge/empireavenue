require 'empireavenue/error/client_error'

module EmpireAvenue
  class Error
    # Raised when Empire Avenue returns the HTTP status code 403
    class Forbidden < EmpireAvenue::Error::ClientError
      HTTP_STATUS_CODE = 403
    end
  end
end