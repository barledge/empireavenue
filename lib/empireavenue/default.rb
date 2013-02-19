require 'faraday'
#require 'faraday/request/multipart'
require 'empireavenue/configurable'
require 'empireavenue/error/client_error'
require 'empireavenue/error/server_error'
#require 'empireavenue/request/multipart_with_file'
require 'empireavenue/response/parse_json'
require 'empireavenue/response/raise_error'
require 'empireavenue/version'

module EmpireAvenue
  module Default
    ENDPOINT = 'https://api.empireavenue.com' unless defined? EmpireAvenue::Default::ENDPOINT
    CONNECTION_OPTIONS = {
      :headers => {
        :accept => 'application/json',
        :user_agent => "EmpireAvenue Ruby Gem #{EmpireAvenue::Version}",
      },
      :request => {
        :open_timeout => 5,
        :timeout => 10,
      },
      :params => {
      },
      :ssl => {
        :verify => false
      },
    } unless defined? EmpireAvenue::Default::CONNECTION_OPTIONS
    IDENTITY_MAP = false unless defined? EmpireAvenue::Default::IDENTITY_MAP
    MIDDLEWARE = Faraday::Builder.new do |builder|
      # Convert file uploads to Faraday::UploadIO objects
      #builder.use EmpireAvenue::Request::MultipartWithFile
      # Checks for files in the payload
      #builder.use Faraday::Request::Multipart
      # Convert request params to "www-form-urlencoded"
      builder.use Faraday::Request::UrlEncoded
      # Handle 4xx server responses
      builder.use EmpireAvenue::Response::RaiseError, EmpireAvenue::Error::ClientError
      # Parse JSON response bodies using MultiJson
      builder.use EmpireAvenue::Response::ParseJson
      # Handle 5xx server responses
      builder.use EmpireAvenue::Response::RaiseError, EmpireAvenue::Error::ServerError
      # Set Faraday's HTTP adapter
      builder.adapter Faraday.default_adapter
    end unless defined? EmpireAvenue::Default::MIDDLEWARE

    class << self

      # @return [Hash]
      def options
        Hash[EmpireAvenue::Configurable.keys.map{|key| [key, send(key)]}]
      end

      # @return [String]sferik
      def client_id
        ENV['EMPIRE_AVENUE_CLIENT_ID']
      end

      # @return [String]
      def client_secret
        ENV['EMPIRE_AVENUE_CLIENT_SECRET']
      end

      # @return [String]
      def oauth_token
        ENV['EMPIRE_AVENUE_OAUTH_TOKEN']
      end

      # @return [String]
      def oauth_token_secret
        ENV['EMPIRE_AVENUE_OAUTH_TOKEN_SECRET']
      end

      # @note This is configurable in case you want to use a Empire Avenue-compatible endpoint.
      # @return [String]
      def endpoint
        ENDPOINT
      end

      def connection_options
        CONNECTION_OPTIONS
      end
      
      def identity_map
        IDENTITY_MAP
      end

      # @note Faraday's middleware stack implementation is comparable to that of Rack middleware.  The order of middleware is important: the first middleware on the list wraps all others, while the last middleware is the innermost one.
      # @see http://mislav.uniqpath.com/2011/07/faraday-advanced-http/
      # @return [Faraday::Builder]
      def middleware
        MIDDLEWARE
      end

    end
  end
end