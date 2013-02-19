empireavenue
============
[![Build Status](https://travis-ci.org/txwikinger/empireavenue.png)](https://travis-ci.org/txwikinger/empireavenue)
[gem]: https://rubygems.org/gems/empireavenue


A Ruby interface to the Empire Avenue API 

## Installation 
    gem install empireavenue


The interface can be used by calling by 

```ruby
require 'empireavenue'

ea = EmpireAvenue::Client.new({client_id = <client_id of app from EAv>, oauth_token = <oauth_token received from EAv authentication>)
```

Now this client can perform requests to the Empire Avenue API

Profile Info of accounts

```ruby 
ea.profile_info(ticker = nil)
```

receives the profile information of the given ticker. If no argument is given, the associated profile of the authenticated user is provided. Ticker can be a list of up to tickers in an Array.

