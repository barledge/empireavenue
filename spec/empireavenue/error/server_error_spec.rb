require 'helper'

describe EmpireAvenue::Error::ServerError do

  before do
    @client = EmpireAvenue::Client.new(:client_id => "CK", :client_secret => "CS", :oauth_token => "OT", :oauth_token_secret => "OS")
  end

  EmpireAvenue::Error::ServerError.errors.each do |status, exception|
    context "when HTTP status is #{status}" do
      before do
        stub_get("/profile/info").with(:query => {:client_id => @client.client_id, :access_token => @client.oauth_token}.merge({:ticker => 'txwikinger'})).to_return(:status => status)
      end
      it "raises #{exception.name}" do
        expect{@client.profile_info('txwikinger')}.to raise_error exception
      end
    end
  end

end
