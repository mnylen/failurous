To use Failurous from Rails 3 application, add this to your Gemfile:

    gem 'failurous-rails', :git => 'git://github.com/railsrumble/rr10-team-256.git'


Next you need to add the following under config/initializer/failurous.rb:

    require 'failurous'

    Failurous::Config.server_address = '<FAILUROUS-INSTALLATION>'
    Failurous::Config.api_key = '<API-KEY-FOR-PROJECT>'

    Rails.application.config.middleware.use Failurous::FailMiddleware
