# Failurous

Failurous is an open source webapp for monitoring exceptions in your
live applications.

## Installation

The Failurous server is pretty much just a cookie-cutter Rails 3 application, which uses MongoDB as the backend. As prerequisites you'll need:

* [MongoDB](http://www.mongodb.org/downloads)
* Ruby 1.8 or newer

When you have these two installed, and MongoDB is up and running, just clone this repository and run `bundle install` to install the required gems. Then hit `rails server -e production` to start the app. By default the server will start in port 3000.

## Configuration

### Database

You can configure the database connection from `config/mongoid.yml`. Please refer to the Mongoid documentation for instructions.

### Email notifications

By default, all email notifications are sent from email address _failurous@domain.com_ You might want to change these
settings in `config/application.rb`:

* `EMAIL_NOTIFICATION_SENDER` - the email address to send email notifications from
* `EMAIL_NOTIFICATION_SUBJECT_PREFIX` - the prefix used for email notifications

## Clients

* Ruby - [failurous-ruby](http://github.com/mnylen/failurous-ruby)
* Rails 3 &amp; Rails 2.3.x - [failurous-rails](http://github.com/mnylen/failurous-rails)
* Java - [failurous-java](http://github.com/teropa/failurous-java)

## Support & Bug Reports

[Failurous Lighthouse](http://failurous.lighthouseapp.com/dashboard)

## License

Copyright (c) 2010 Mikko Nylén, Tero Parviainen & Antti Forsell

See LICENSE


