require 'helper'

describe EmpireAvenue::API::Profile do
  
  subject do
    EmpireAvenue::Client.new(:client_id => "CK", :client_secret => "CS", :oauth_token => "OT", :oauth_token_secret => "OS")
  end

  it "buys shares with last trade price provided" do
    avidbeaver_buy_info =  FactoryGirl.build(:shares_buy_data) 
    stub_post("/shares/buy").with(:query => {:client_id => subject.client_id, :access_token => subject.oauth_token}, :body => {:ticker => "AVIDBEAVER", :shares => "5", :last_trade => "150.50"}).to_return(:body => FactoryGirl.build(:response, requested_user: "AVIDBEAVER", data: [avidbeaver_buy_info]).to_json, :headers => {:content_type => "application/json; charset=utf-8"})
    info = subject.shares_buy("AVIDBEAVER", 5, "150.50")
    expect(a_post("/shares/buy").with(:query => {:client_id => subject.client_id, :access_token => subject.oauth_token}, :body => {:ticker => "AVIDBEAVER", :shares => "5", :last_trade => "150.50"})).to have_been_made
    expect(info[:body][:meta][:total_rows]).to eq 1
    expect(info[:body][:data][0][:success]).to eq true
  end

  it "buys shares without last trade price provided" do
    avidbeaver_info = FactoryGirl.build(:profile_info_data, ticker: "AVIDBEAVER")
    avidbeaver_buy_info =  FactoryGirl.build(:shares_buy_data) 
    stub_get("/profile/info").with(:query => {:client_id => subject.client_id, :access_token => subject.oauth_token, :ticker => "AVIDBEAVER"}).to_return(:body => FactoryGirl.build(:response, data: [avidbeaver_info]).to_json, :headers => {:content_type => "application/json; charset=utf-8"})
    stub_post("/shares/buy").with(:query => {:client_id => subject.client_id, :access_token => subject.oauth_token}, :body => {:ticker => "AVIDBEAVER", :shares => "5", :last_trade => avidbeaver_info.last_trade}).to_return(:body => FactoryGirl.build(:response, requested_user: "AVIDBEAVER", data: [avidbeaver_buy_info]).to_json, :headers => {:content_type => "application/json; charset=utf-8"})
    info = subject.shares_buy("AVIDBEAVER", 5)
    expect(a_get("/profile/info").with(:query => {:ticker => "AVIDBEAVER", :client_id => subject.client_id, :access_token => subject.oauth_token})).to have_been_made 
    expect(a_post("/shares/buy").with(:query => {:client_id => subject.client_id, :access_token => subject.oauth_token}, :body => {:ticker => "AVIDBEAVER", :shares => "5", :last_trade => avidbeaver_info.last_trade})).to have_been_made
    expect(info[:body][:meta][:total_rows]).to eq 1
    expect(info[:body][:data][0][:success]).to eq true
  end

  
end