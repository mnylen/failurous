# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{failurous-rails}
  s.version = "0.1.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mikko Nylén", "Tero Parviainen", "Antti Forsell"]
  s.date = %q{2010-10-17}
  s.description = %q{Failurous is an open source webapp for monitoring exceptions in your live applications. failurous-rails is a Rails plugin that allows you to send easily notifications of new fails to your Failurous installation.}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.md"
  ]
  s.files = [
    "client/failurous.rb",
     "client/failurous/config.rb",
     "client/failurous/fail_middleware.rb",
     "client/failurous/fail_notification.rb",
     "client/failurous/fail_notifier.rb"
  ]
  s.homepage = %q{http://github.com/railsrumble/rr10-team-256}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["client"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Notifier for sending fails to Failurous installation}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 2.3.5"])
      s.add_runtime_dependency(%q<actionpack>, [">= 2.3.5"])
    else
      s.add_dependency(%q<activesupport>, [">= 2.3.5"])
      s.add_dependency(%q<actionpack>, [">= 2.3.5"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 2.3.5"])
    s.add_dependency(%q<actionpack>, [">= 2.3.5"])
  end
end

