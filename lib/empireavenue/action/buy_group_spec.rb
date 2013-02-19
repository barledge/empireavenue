require 'helper'

describe EmpireAvenue::API::Profile do
  
  subject do
    EmpireAvenue::Client.new(:client_id => "CK", :client_secret => "CS", :oauth_token => "OT", :oauth_token_secret => "OS")
  end
  
  before do
    @ticker_list = ["AVIDBEAVER", "TXWIKINGER"]
  end

  it "buys all tickers in list with given share number" do
    
  end
  

   it "buys all tickers in list with maximum given amount" do
    
  end

     
  it "buys all tickers in list with closest above given amount" do
    
  end
  
   it "buys all tickers in list " do
    
  end

end