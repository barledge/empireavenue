require 'helper'

describe EmpireAvenue::API::Profile do
  
  subject do
    EmpireAvenue::Client.new(:client_id => "CK", :client_secret => "CS", :oauth_token => "OT", :oauth_token_secret => "OS")
  end
  
  before(:all) do
    @txwikinger_shareholders = FactoryGirl.build(:profile_shareholders_data, ticker: "TXWIKINGER")
    @avidbeaver_shareholders = FactoryGirl.build(:profile_shareholders_data, ticker: "AVIDBEAVER")
  end
  
  it "gets profile shareholders without ticker" do
    stub_get("/profile/shareholders").with(:query => {:client_id => subject.client_id, :access_token => subject.oauth_token}).to_return(:body => FactoryGirl.build(:response, data: [@txwikinger_shareholders]).to_json, :headers => {:content_type => "application/json; charset=utf-8"})
    shareholders = subject.profile_shareholders
    expect(a_get("/profile/shareholders").with(:query => {:client_id => subject.client_id, :access_token => subject.oauth_token})).to have_been_made
    expect(shareholders[:body][:meta][:total_rows]).to eq 1
    expect(shareholders[:body][:data][0][:ticker]).to eq "TXWIKINGER"
  end
  
  it "gets profile shareholders with ticker" do
    stub_get("/profile/shareholders").with(:query => {:client_id => subject.client_id, :access_token => subject.oauth_token, :ticker => "AVIDBEAVER"}).to_return(:body => FactoryGirl.build(:response, data: [@avidbeaver_shareholders]).to_json, :headers => {:content_type => "application/json; charset=utf-8"})
    shareholders = subject.profile_shareholders("AVIDBEAVER")
    expect(a_get("/profile/shareholders").with(:query => {:ticker => "AVIDBEAVER", :client_id => subject.client_id, :access_token => subject.oauth_token})).to have_been_made
    expect(shareholders[:body][:meta][:total_rows]).to eq 1
    expect(shareholders[:body][:data][0][:ticker]).to eq "AVIDBEAVER"
  end

  it "gets profile shareholders page 2" do
    stub_get("/profile/shareholders").with(:query => {:page => 2, :client_id => subject.client_id, :access_token => subject.oauth_token}).to_return(:body => FactoryGirl.build(:response, requested_user: "AVIDBEAVER", requested_page: 2, data: [@txwikinger_shareholders]).to_json, :headers => {:content_type => "application/json; charset=utf-8"})
    shareholders = subject.profile_shareholders(nil, 2)
    expect(a_get("/profile/shareholders").with(:query => {:page => 2, :client_id => subject.client_id, :access_token => subject.oauth_token})).to have_been_made    
    expect(shareholders[:body][:meta][:total_rows]).to eq 1
    expect(shareholders[:body][:meta][:requested_user]).to eq "AVIDBEAVER"
    expect(shareholders[:body][:meta][:requested_page]).to eq 2    
    expect(shareholders[:body][:data][0][:ticker]).to eq "TXWIKINGER"
   end
   
  it "gets profile shareholders limit to 1 result" do
    stub_get("/profile/shareholders").with(:query => {:maxresults => 1, :client_id => subject.client_id, :access_token => subject.oauth_token}).to_return(:body => FactoryGirl.build(:response, requested_user: "AVIDBEAVER", requested_page: 1, data: [@txwikinger_shareholders]).to_json, :headers => {:content_type => "application/json; charset=utf-8"})
    shareholders = subject.profile_shareholders(nil, nil, 1)
    expect(a_get("/profile/shareholders").with(:query => {:maxresults => 1, :client_id => subject.client_id, :access_token => subject.oauth_token})).to have_been_made    
    expect(shareholders[:body][:meta][:total_rows]).to eq 1
    expect(shareholders[:body][:meta][:requested_user]).to eq "AVIDBEAVER"
    expect(shareholders[:body][:meta][:requested_page]).to eq 1    
    expect(shareholders[:body][:data][0][:ticker]).to eq "TXWIKINGER"
   end
   
end