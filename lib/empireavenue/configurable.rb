require 'forwardable'
require 'empireavenue/error/configuration_error'

module EmpireAvenue
  module Configurable
    extend Forwardable
    attr_accessor :client_id, :client_secret, :oauth_token, :oauth_token_secret
    attr_accessor :endpoint, :connection_options, :identity_map, :middleware
    def_delegator :options, :hash

    class << self

      def keys
        @keys ||= [
          :client_id,
          :client_secret,
          :oauth_token,
          :oauth_token_secret,
          :endpoint,
          :connection_options,
	  :identity_map,
          :middleware,
        ]
      end

    end

    # Convenience method to allow configuration options to be set in a block
    #
    # @raise [EmpireAvenue::Error::ConfigurationError] Error is raised when supplied
    #   empire avenue credentials are not a String or Symbol.
    def configure
      yield self
      validate_credential_type!
      self
    end

    # @return [Boolean]
    def credentials?
      credentials.values.all?
    end

    def reset!
      EmpireAvenue::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", EmpireAvenue::Default.options[key])
      end
      self
    end
    alias setup reset!

  private

    # @return [Hash]
    def credentials
      {
        :client_id => @client_id,
        :client_secret => @client_secret,
        :token => @oauth_token,
        :token_secret => @oauth_token_secret,
      }
    end

    # @return [Hash]
    def options
      Hash[EmpireAvenue::Configurable.keys.map{|key| [key, instance_variable_get(:"@#{key}")]}]
    end

    # Ensures that all credentials set during configuration are of a
    # valid type. Valid types are String and Symbol.
    #
    # @raise [EmpireAvenue::Error::ConfigurationError] Error is raised when
    #   supplied empire avenue credentials are not a String or Symbol.
    def validate_credential_type!
      credentials.each do |credential, value|
        next if value.nil?

        unless value.is_a?(String) || value.is_a?(Symbol)
          raise(Error::ConfigurationError, "Invalid #{credential} specified: #{value} must be a string or symbol.")
        end
      end
    end

  end
end