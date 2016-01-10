# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks


desc 'database tasks'
namespace :db do
  desc 'truncate all data'
  task :truncate => :environment do
    User.redis.flushdb
  end

  desc 'seed default data'
  task :seed => :environment do
    require File.expand_path('../db/seeds', __FILE__)
  end
end

