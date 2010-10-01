# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

Todo::Application.load_tasks

namespace :test do
  task :units do
    require 'cutest'
    Cutest.run(Dir['test/unit/*.rb'])
  end

  task :integration do
    require 'cutest'
    Cutest.run(Dir['test/integration/*.rb'])
  end
end