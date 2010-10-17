# Failurous

Failurous is an open source webapp for monitoring exceptions in your
live applications.

## Installation

### Server

### Clients

#### Rails 3

To use Failurous from Rails 3 application, add this to your Gemfile:

    gem 'failurous-rails', :git => 'git@github.com:railsrumble/rr10-team-256.git'


Next you need to add the following under config/initializer/failurous.rb:

    require 'failurous'

    Failurous::Config.server_address = '<FAILUROUS-INSTALLATION>'
    Failurous::Config.api_key = '<API-KEY-FOR-PROJECT>'

    Rails.application.config.middleware.insert_before(Rails.application.config.session_store,
      Failurous::FailMiddleware)
      
The middleware will automatically catch any exceptions your app raises and
deliver them to the Failurous service for later viewing.

## Sending fails

Often there's cases where it'd be desirable to be able to send debugging
information or notifications of "failurous" behaviour in your application. For
example, when someone tries to access protected content without proper access
rights.

Failurous comes in handy here, because it's not limited to only
exceptions: you can actually send any data you like.

### In Rails applications

To send your custom fails to Failurous, you can use the
`Failurous::FailNotification` to build your fail and send it. The syntax is
as follows:

    Failurous::FailNotification.set_title('Title for your fail').
      add_field(:section_name, :field_name, {:use_in_checksum => true | false}).
      add_field(:another, :field, {...}).
      send


## License

Copyright (c) 2010 Mikko Nylén, Tero Parviainen & Antti Forsell

See LICENSE


