unless ENV['CI']
  require 'simplecov'
  SimpleCov.start do
    add_filter 'spec'
  end
end

require 'empireavenue'
require 'rspec'
require 'webmock/rspec'
require 'factory_girl'

FactoryGirl.find_definitions

def a_delete(path)
  a_request(:delete, EmpireAvenue::Default::ENDPOINT + path)
end

def a_get(path)
  a_request(:get, EmpireAvenue::Default::ENDPOINT + path)
end

def a_post(path)
  a_request(:post, EmpireAvenue::Default::ENDPOINT + path)
end

def a_put(path)
  a_request(:put, EmpireAvenue::Default::ENDPOINT + path)
end

def stub_delete(path)
  stub_request(:delete, EmpireAvenue::Default::ENDPOINT + path)
end

def stub_get(path)
  stub_request(:get, EmpireAvenue::Default::ENDPOINT + path)
end

def stub_post(path)
  stub_request(:post, EmpireAvenue::Default::ENDPOINT + path)
end

def stub_put(path)
  stub_request(:put, EmpireAvenue::Default::ENDPOINT + path)
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end