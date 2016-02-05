# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'pry'
require './config/environment'
Rails.application.load_tasks


desc "Import the courses"
task "get_courses" do
  require './db/import/import_courses.rb'
end

