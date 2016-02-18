# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'pry'
require './config/environment'
Rails.application.load_tasks


desc "Import all the data, courses offerings and fake data"
task "get_data" do
  require './db/import/destroy_all.rb'
  require './db/import/import_courses.rb'
  require './db/import/import_offerings.rb'
  require './db/import/import_professors.rb'
  require './db/import/import_preferences.rb'
  require './db/import/import_ourconfig.rb'
end

