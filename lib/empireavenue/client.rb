require 'faraday'
require 'multi_json'
#require 'oauth2'
require 'uri'
require 'empireavenue/default'
require 'empireavenue/api/profile_info'
require 'empireavenue/api/profile_bank_balance'
require 'empireavenue/api/search_recent'
require 'empireavenue/api/shares_buy'
require 'empireavenue/error/client_error'
require 'empireavenue/error/decode_error'

module EmpireAvenue
  # Wrapper for the Empire Avenue API
  #
  class Client
    include EmpireAvenue::API::Profile
    include EmpireAvenue::API::Shares
    include EmpireAvenue::API::Search
    include EmpireAvenue::Configurable

    # Initializes a new Client object
    #
    # @param options [Hash]
    # @return [EmpireAvenue::Client]
    def initialize(options={})
      EmpireAvenue::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", options[key] || EmpireAvenue.instance_variable_get(:"@#{key}"))
      end
    end

    # Perform an HTTP DELETE request
    def delete(path, params={})
      request(:delete, path, params)
    end

    # Perform an HTTP GET request
    def get(path, params={})
      request(:get, path, params)
    end

    # Perform an HTTP POST request
    def post(path, params={})
      signature_params = params.values.any?{|value| value.respond_to?(:to_io)} ? {} : params
      request(:post, path, params, signature_params)
    end

    # Perform an HTTP PUT request
    def put(path, params={})
      request(:put, path, params)
    end

  private

    def request(method, path, params={}, signature_params=params)
      #params[:client_id] ||= @client_id
      #params[:access_token] = params[:oauth_token]
      #params[:access_token] ||= @oauth_token
      #connection.params = params
      connection.send(method.to_sym, path, params) do |request|
	#request.params[:client_id] = params[:client_id]
	#request.params[:access_token] = params[:access_token]
        #request.headers[:authorization] = auth_header(method.to_sym, path, signature_params).to_s
      end.env
    rescue Faraday::Error::ClientError
      raise EmpireAvenue::Error::ClientError
    rescue MultiJson::DecodeError
      raise EmpireAvenue::Error::DecodeError
    end

    # Returns a Faraday::Connection object
    #
    # @return [Faraday::Connection]
    def connection
      @connection ||= Faraday.new(@endpoint, @connection_options.merge(:builder => @middleware).merge({:params => {:client_id => @client_id, :access_token => @oauth_token}}))
    end

    #def auth_header(method, path, params={})
    #  uri = URI(@endpoint + path)
    #  #OAuth2::Header.new(method, uri, params, credentials)
    #end

  end
end
