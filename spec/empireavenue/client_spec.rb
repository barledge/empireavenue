require 'helper'

describe EmpireAvenue::Client do

  subject do
    EmpireAvenue::Client.new(:client_id => "CK", :client_secret => "CS", :oauth_token => "OT", :oauth_token_secret => "OS")
  end

  context "with module configuration" do

    before do
      EmpireAvenue.configure do |config|
        EmpireAvenue::Configurable.keys.each do |key|
          config.send("#{key}=", key)
        end
      end
    end

    after do
      EmpireAvenue.reset!
    end

    it "inherits the module configuration" do
      client = EmpireAvenue::Client.new
      EmpireAvenue::Configurable.keys.each do |key|
        expect(client.instance_variable_get(:"@#{key}")).to eq key
      end
    end

    context "with class configuration" do

      before do
        @configuration = {
          :connection_options => {:timeout => 10},
          :client_id => 'CK',
          :client_secret => 'CS',
          :endpoint => 'http://tumblr.com/',
          :middleware => Proc.new{},
          :oauth_token => 'OT',
          :oauth_token_secret => 'OS',
          :identity_map => ::Hash
        }
      end

      context "during initialization" do
        it "overrides the module configuration" do
          client = EmpireAvenue::Client.new(@configuration)
          EmpireAvenue::Configurable.keys.each do |key|
            expect(client.instance_variable_get(:"@#{key}")).to eq @configuration[key]
          end
        end
      end

      context "after initialization" do
        it "overrides the module configuration after initialization" do
          client = EmpireAvenue::Client.new
          client.configure do |config|
            @configuration.each do |key, value|
              config.send("#{key}=", value)
            end
          end
          EmpireAvenue::Configurable.keys.each do |key|
            expect(client.instance_variable_get(:"@#{key}")).to eq @configuration[key]
          end
        end
      end

    end
  end

  it "does not cache the ticker across clients" do
    txwikinger_info = FactoryGirl.build(:profile_info_data, ticker: "TXWIKINGER")
    avidbeaver_info = FactoryGirl.build(:profile_info_data, ticker: "AVIDBEAVER")

    stub_get("/profile/info").with(:query => {:client_id => subject.client_id, :access_token => subject.oauth_token}).to_return(:body => FactoryGirl.build(:response, data: [txwikinger_info]).to_json, :headers => {:content_type => "application/json; charset=utf-8"})
    client1 = EmpireAvenue::Client.new(:client_id => "CK", :client_secret => "CS", :oauth_token => "OT", :oauth_token_secret => "OS")
    expect(client1.profile_info[:body][:data][0][:ticker]).to eq "TXWIKINGER"
    stub_get("/profile/info").with(:query => {:client_id => subject.client_id, :access_token => subject.oauth_token}).to_return(:body => FactoryGirl.build(:response, data: [avidbeaver_info]).to_json, :headers => {:content_type => "application/json; charset=utf-8"})
    client2 = EmpireAvenue::Client.new(:client_id => "CK", :client_secret => "CS", :oauth_token => "OT", :oauth_token_secret => "OS")
    expect(client2.profile_info[:body][:data][0][:ticker]).to eq "AVIDBEAVER"
  end
  
  describe "#post" do
    before do
      #@client = EmpireAvenue::Client.new
      stub_post("/shares/buy").with(:query => {:client_id => subject.client_id, :access_token => subject.oauth_token}, :body => {"shares" => "1", "ticker" => "AVIDBEAVER", "last_trade" => "150.445"})
    end
    it "allows custom post requests" do
      subject.post("/shares/buy", {:shares => 1, :ticker => "AVIDBEAVER", :last_trade => 150.445})
      expect(a_post("/shares/buy").with(:query => {:client_id => subject.client_id, :access_token => subject.oauth_token}, :body => 'shares=1&ticker=AVIDBEAVER&last_trade=150.445')).to have_been_made
    end
  end
    
  describe "#delete" do
    before do
      #@client = EmpireAvenue::Client.new
      stub_delete("/custom/delete").with(:query => {:client_id => subject.client_id, :access_token => subject.oauth_token}.merge({:deleted => "object"}))
    end
    it "allows custom delete requests" do
      subject.delete("/custom/delete", {:deleted => "object"})
      expect(a_delete("/custom/delete").with(:query => {:client_id => subject.client_id, :access_token => subject.oauth_token}.merge({:deleted => "object"}))).to have_been_made
    end
  end

  describe "#put" do
    before do
      stub_put("/custom/put").with({:query => {:client_id => subject.client_id, :access_token => subject.oauth_token}, :body => {:updated => "object"}})
    end
    it "allows custom put requests" do
      pending "odd split method not found error"
      subject.put("/custom/put", {:updated => "object"})
      expect(a_put("/custom/put").with({:query => {:client_id => subject.client_id, :access_token => subject.oauth_token}, :body => {:updated => "object"}})).to have_been_made
    end
  end

  describe "#credentials?" do
    it "returns true if all credentials are present" do
      client = EmpireAvenue::Client.new(:client_id => 'CK', :client_secret => 'CS', :oauth_token => 'OT', :oauth_token_secret => 'OS')
      expect(client.credentials?).to be_true
    end
    it "returns false if any credentials are missing" do
      client = EmpireAvenue::Client.new(:client_id => 'CK', :client_secret => 'CS', :oauth_token => 'OT')
      expect(client.credentials?).to be_false
    end
  end
  
  describe "#connection" do
    it "looks like Faraday connection" do
      expect(subject.send(:connection)).to respond_to(:run_request)
    end
    it "memoizes the connection" do
      c1, c2 = subject.send(:connection), subject.send(:connection)
      expect(c1.object_id).to eq c2.object_id
    end
  end
  
    describe "#request" do
    it "catches Faraday errors" do
      subject.stub!(:connection).and_raise(Faraday::Error::ClientError.new("Oops"))
      expect{subject.send(:request, :get, "/path")}.to raise_error EmpireAvenue::Error::ClientError
    end
    it "catches MultiJson::DecodeError errors" do
      subject.stub!(:connection).and_raise(MultiJson::DecodeError.new("unexpected token", [], "<!DOCTYPE html>"))
      expect{subject.send(:request, :get, "/path")}.to raise_error EmpireAvenue::Error::DecodeError
    end
  end


end
