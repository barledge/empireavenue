require 'helper'

describe EmpireAvenue::API::Profile do
  
  subject do
    EmpireAvenue::Client.new(:client_id => "CK", :client_secret => "CS", :oauth_token => "OT", :oauth_token_secret => "OS")
  end
  
  before(:all) do
    @txwikinger_info = FactoryGirl.build(:profile_info_data, ticker: "TXWIKINGER")
    @avidbeaver_info = FactoryGirl.build(:profile_info_data, ticker: "AVIDBEAVER")
  end
  
  it "gets profile info without ticker" do
    stub_get("/profile/info").with(:query => {:client_id => subject.client_id, :access_token => subject.oauth_token}).to_return(:body => FactoryGirl.build(:response, data: [@txwikinger_info]).to_json, :headers => {:content_type => "application/json; charset=utf-8"})
    info = subject.profile_info
    expect(a_get("/profile/info").with(:query => {:client_id => subject.client_id, :access_token => subject.oauth_token})).to have_been_made
    expect(info[:body][:meta][:total_rows]).to eq 1
    expect(info[:body][:data][0][:ticker]).to eq "TXWIKINGER"
  end
  
  it "gets profile info with ticker" do
    stub_get("/profile/info").with(:query => {:client_id => subject.client_id, :access_token => subject.oauth_token, :ticker => "AVIDBEAVER"}).to_return(:body => FactoryGirl.build(:response, data: [@avidbeaver_info]).to_json, :headers => {:content_type => "application/json; charset=utf-8"})
    info = subject.profile_info("AVIDBEAVER")
    expect(a_get("/profile/info").with(:query => {:ticker => "AVIDBEAVER", :client_id => subject.client_id, :access_token => subject.oauth_token})).to have_been_made
    expect(info[:body][:meta][:total_rows]).to eq 1
    expect(info[:body][:data][0][:ticker]).to eq "AVIDBEAVER"
  end

  it "gets profile info with multiple tickers" do
    stub_get("/profile/info").with(:query => {:ticker => "TXWIKINGER,AVIDBEAVER", :client_id => subject.client_id, :access_token => subject.oauth_token}).to_return(:body => FactoryGirl.build(:response, data: [@txwikinger_info, @avidbeaver_info]).to_json, :headers => {:content_type => "application/json; charset=utf-8"})
    info = subject.profile_info(["TXWIKINGER", "AVIDBEAVER"])
    expect(a_get("/profile/info").with(:query => {:ticker => "TXWIKINGER,AVIDBEAVER", :client_id => subject.client_id, :access_token => subject.oauth_token})).to have_been_made    
    expect(info[:body][:meta][:total_rows]).to eq 2
    expect(info[:body][:data][0][:ticker]).to eq "TXWIKINGER"
    expect(info[:body][:data][1][:ticker]).to eq "AVIDBEAVER"
  end
end