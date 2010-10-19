# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

Failurous::Application.load_tasks

task :build_java_client do
  sh "cd java-client && mvn clean install -DcreateChecksum=true"
  FileUtils.mkdir_p "public/mvnrepo"
  FileUtils.cp_r File.join(ENV["HOME"], ".m2", "repository", "failurous"), "public/mvnrepo"
end
