require 'empireavenue/error/server_error'

module EmpireAvenue
  class Error
    # Raised when EmpireAvenue returns the HTTP status code 503
    class ServiceUnavailable < EmpireAvenue::Error::ServerError
      HTTP_STATUS_CODE = 503
      MESSAGE = "(__-){ EmpireAvenue is over capacity."
    end
  end
end
