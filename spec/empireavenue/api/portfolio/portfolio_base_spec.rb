require 'helper'

describe EmpireAvenue::API::Portfolio do
  
  subject do
    EmpireAvenue::Client.new(:client_id => "CK", :client_secret => "CS", :oauth_token => "OT", :oauth_token_secret => "OS")
  end
  
  before(:all) do
    @txwikinger_info = FactoryGirl.build(:portfolio_base_data, ticker: "TXWIKINGER")
    @avidbeaver_info = FactoryGirl.build(:portfolio_base_data, ticker: "AVIDBEAVER")
  end
  
  it "gets portfolio base info without ticker" do
    stub_get("/portfolio/base").with(:query => {:client_id => subject.client_id, :access_token => subject.oauth_token}).to_return(:body => FactoryGirl.build(:response, data: [@txwikinger_info]).to_json, :headers => {:content_type => "application/json; charset=utf-8"})
    info = subject.portfolio_base
    expect(a_get("/portfolio/base").with(:query => {:client_id => subject.client_id, :access_token => subject.oauth_token})).to have_been_made
    expect(info[:body][:meta][:total_rows]).to eq 1
    expect(info[:body][:data][0][:ticker]).to eq "TXWIKINGER"
  end
  
  it "gets portfolio base info with ticker" do
    stub_get("/portfolio/base").with(:query => {:client_id => subject.client_id, :access_token => subject.oauth_token, :ticker => "AVIDBEAVER"}).to_return(:body => FactoryGirl.build(:response, data: [@avidbeaver_info]).to_json, :headers => {:content_type => "application/json; charset=utf-8"})
    info = subject.portfolio_base("AVIDBEAVER")
    expect(a_get("/portfolio/base").with(:query => {:ticker => "AVIDBEAVER", :client_id => subject.client_id, :access_token => subject.oauth_token})).to have_been_made
    expect(info[:body][:meta][:total_rows]).to eq 1
    expect(info[:body][:data][0][:ticker]).to eq "AVIDBEAVER"
  end
  
  it "gets page 2 of the portfolio base info" do
    stub_get("/portfolio/base").with(:query => {:page => 2, :client_id => subject.client_id, :access_token => subject.oauth_token}).to_return(:body => FactoryGirl.build(:response, requested_user: "AVIDBEAVER", requested_page: 2, data: [@txwikinger_info]).to_json, :headers => {:content_type => "application/json; charset=utf-8"})
    info = subject.portfolio_base(nil, 2)
    expect(a_get("/portfolio/base").with(:query => {:page => 2, :client_id => subject.client_id, :access_token => subject.oauth_token})).to have_been_made
    expect(info[:body][:meta][:total_rows]).to eq 1
    expect(info[:body][:meta][:requested_user]).to eq "AVIDBEAVER"
    expect(info[:body][:meta][:requested_page]).to eq 2
    expect(info[:body][:data][0][:ticker]).to eq "TXWIKINGER"
  end  

  it "gets portfolio base info with limit of 1 profile" do
    stub_get("/portfolio/base").with(:query => {:maxresults => 1, :client_id => subject.client_id, :access_token => subject.oauth_token}).to_return(:body => FactoryGirl.build(:response, requested_user: "AVIDBEAVER", requested_page: 1, data: [@txwikinger_info]).to_json, :headers => {:content_type => "application/json; charset=utf-8"})
    info = subject.portfolio_base(nil, nil, 1)
    expect(a_get("/portfolio/base").with(:query => {:maxresults => 1, :client_id => subject.client_id, :access_token => subject.oauth_token})).to have_been_made
    expect(info[:body][:meta][:total_rows]).to eq 1
    expect(info[:body][:meta][:requested_user]).to eq "AVIDBEAVER"
    expect(info[:body][:meta][:requested_page]).to eq 1
    expect(info[:body][:data][0][:ticker]).to eq "TXWIKINGER"
  end  
end