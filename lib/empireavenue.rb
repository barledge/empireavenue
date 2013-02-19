require 'empireavenue/default'
require 'empireavenue/client'
require 'empireavenue/configurable'
require 'empireavenue/entity'
require 'empireavenue/error'
require 'empireavenue/user'

module EmpireAvenue
  class << self
    include EmpireAvenue::Configurable

    # Delegate to a EmpireAvenue::Client
    #
    # @return [EmpireAvenue::Client]
    def client
      @client = EmpireAvenue::Client.new(options) unless defined?(@client) && @client.hash == options.hash
    end

    def respond_to_missing?(method_name, include_private=false); client.respond_to?(method_name, include_private); end if RUBY_VERSION >= "1.9"
    def respond_to?(method_name, include_private=false); client.respond_to?(method_name, include_private) || super; end if RUBY_VERSION < "1.9"

  private

    def method_missing(method_name, *args, &block)
      return super unless client.respond_to?(method_name)
      client.send(method_name, *args, &block)
    end

  end
end

EmpireAvenue.setup