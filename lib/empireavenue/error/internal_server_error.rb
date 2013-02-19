require 'empireavenue/error/server_error'

module EmpireAvenue
  class Error
    # Raised when EmpireAvenue returns the HTTP status code 500
    class InternalServerError < EmpireAvenue::Error::ServerError
      HTTP_STATUS_CODE = 500
      MESSAGE = "Something is technically wrong."
    end
  end
end
