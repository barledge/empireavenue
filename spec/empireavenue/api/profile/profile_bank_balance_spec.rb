require 'helper'

describe EmpireAvenue::API::Profile do
  
  subject do
    EmpireAvenue::Client.new(:client_id => "CK", :client_secret => "CS", :oauth_token => "OT", :oauth_token_secret => "OS")
  end

  it "gets profile info without ticker" do
    bank_balance_info = FactoryGirl.build(:profile_bank_balance_data)
    stub_get("/profile/bank/balance").with(:query => {:client_id => subject.client_id, :access_token => subject.oauth_token}).to_return(:body => FactoryGirl.build(:response, requested_user: "AVIDBEAVER", data: [bank_balance_info]).to_json, :headers => {:content_type => "application/json; charset=utf-8"})
    info = subject.profile_bank_balance
    expect(a_get("/profile/bank/balance").with(:query => {:client_id => subject.client_id, :access_token => subject.oauth_token})).to have_been_made
    expect(info[:body][:meta][:total_rows]).to eq 1
    expect(info[:body][:meta][:requested_user]).to eq "AVIDBEAVER"
    expect(info[:body][:data][0][:ticker]).to be_nil
  end  
end