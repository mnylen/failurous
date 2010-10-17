# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

Failurous::Application.load_tasks

require 'jeweler'

Jeweler::Tasks.new do |gem|
  gem.name = "failurous-rails"
  gem.summary = "Notifier for sending fails to Failurous installation"
  gem.description = "Failurous is an open source webapp for monitoring exceptions in your live applications. failurous-rails is a Rails plugin that allows you to send easily notifications of new fails to your Failurous installation."
  gem.authors = ["Mikko Nylén", "Tero Parviainen", "Antti Forsell"]
  gem.homepage = "http://github.com/railsrumble/rr10-team-256"
  gem.files = Dir.glob('client/**/*.rb')
  gem.require_path = "client"
  gem.test_files = []
  gem.add_dependency 'activesupport', '>= 2.3.5'
  gem.add_dependency 'actionpack', '>= 2.3.5'
end