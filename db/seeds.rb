# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

require "demo_fail_generator"

Project.create(:name => "Shatner''s Bassoon Inc.")
Project.create(:name => "Tech Wars")
Project.create(:name => "Llama Inventory")
Project.create(:name => "Sockswapping Intl.")
Project.create(:name => "Fawlty Towers")

DemoFailGenerator.new.run(50)

