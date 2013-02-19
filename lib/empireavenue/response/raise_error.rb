require 'faraday'
#require 'empireavenue/error/bad_gateway'
#require 'empireavenue/error/bad_request'
require 'empireavenue/error/forbidden'
#require 'empireavenue/error/gateway_timeout'
require 'empireavenue/error/internal_server_error'
#require 'empireavenue/error/not_acceptable'
require 'empireavenue/error/not_found'
require 'empireavenue/error/service_unavailable'
#require 'empireavenue/error/too_many_requests'
#require 'empireavenue/error/unauthorized'
#require 'empireavenue/error/unprocessable_entity'

module EmpireAvenue
  module Response
    class RaiseError < Faraday::Response::Middleware

      def on_complete(env)
        status_code = env[:status].to_i
        error_class = @klass.errors[status_code]
        raise error_class.from_response(env) if error_class
      end

      def initialize(app, klass)
        @klass = klass
        super(app)
      end

    end
  end
end