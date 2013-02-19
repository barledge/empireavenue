require 'helper'

describe EmpireAvenue::API::Search do
  
  subject do
    EmpireAvenue::Client.new(:client_id => "CK", :client_secret => "CS", :oauth_token => "OT", :oauth_token_secret => "OS")
  end

  it "gets recent new users without ticker" do
    search_recent_info = FactoryGirl.build(:search_recent_data)
    stub_get("/search/recent").with(:query => {:client_id => subject.client_id, :access_token => subject.oauth_token}).to_return(:body => FactoryGirl.build(:response, total_rows: 100, data: [search_recent_info]).to_json, :headers => {:content_type => "application/json; charset=utf-8"})
    info = subject.search_recent
    expect(a_get("/search/recent").with(:query => {:client_id => subject.client_id, :access_token => subject.oauth_token})).to have_been_made
    expect(info[:body][:meta][:total_rows]).to eq 100
  end  
end