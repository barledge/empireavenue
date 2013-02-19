require 'empireavenue/error/client_error'

module EmpireAvenue
  class Error
    # Raised when Empire Avenue returns the HTTP status code 404
    class NotFound < EmpireAvenue::Error::ClientError
      HTTP_STATUS_CODE = 404
    end
  end
end