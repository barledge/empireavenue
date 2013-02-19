require 'helper'

describe EmpireAvenue::Error::ClientError do

  before do
    @client = EmpireAvenue::Client.new({:client_id => "id", :oauth_token => "ot"})
  end

  it "has correct faraday environment built" do
    @client.middleware.handlers.should include(EmpireAvenue::Response::RaiseError, Faraday::Adapter::NetHttp)
  end
  
  EmpireAvenue::Error::ClientError.errors.each do |status, exception|
    [nil, "error", "errors"].each do |body|
      context "when HTTP status is #{status} and body is #{body.inspect}" do
        before do
          body_message = '{"' + body + '":"Client Error"}' unless body.nil?
          stub_get("/profile/info").with(:query => {:client_id => @client.client_id, :access_token => @client.oauth_token}.merge({ :ticker => 'avidbeaver'})).to_return(:status => status, :body => body_message)
        end
        it "raises #{exception.name}" do
          expect{@client.profile_info('avidbeaver')}.to raise_error exception
        end
      end
    end
  end
  
end