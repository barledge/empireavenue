source :rubygems

gem 'jruby-openssl', :platforms => :jruby
gem 'rake'
#gem 'yard'

group :development do
#  gem 'kramdown'
  gem 'pry'
  gem 'pry-debugger', :platforms => :mri_19
end

group :test do
  gem 'json', :platforms => :ruby_18
  gem 'rspec', '>= 2.11'
  gem 'simplecov'
  gem 'timecop'
  gem 'webmock'
  gem 'factory_girl', '~> 4.0'
end

gemspec
