# Failurous

Failurous is an open source webapp for monitoring exceptions in your
live applications.

## Installation

### Server

### Clients

#### Rails 3

To use Failurous from Rails 3 application, add this to your Gemfile:

    gem 'failurous-rails', :git => 'http://github.com/railsrumble/rr10-team-256'


Next you need to add the following under config/initializer/failurous.rb:

    require 'failurous'

    Failurous::Config.server_address = '<FAILUROUS-INSTALLATION>'
    Failurous::Config.api_key = '<API-KEY-FOR-PROJECT>'

    Rails.application.config.middleware.insert_before(Rails.application.config.session_store,
      Failurous::FailMiddleware)

## License

Copyright (c) 2010 Mikko Nylén, Tero Parviainen & Antti Forsell

See LICENSE


