APP_FILE  = 'opa_app.rb'
APP_CLASS = 'OpaApp'

namespace :bundler do
  task :setup do
    begin
      require 'rubygems'
      require 'bundler/setup'
      Bundler.setup(:default, :development)
    rescue Bundler::BundlerError => e
      $stderr.puts e.message
      $stderr.puts "Run `bundle install` to install missing gems"
      exit e.status_code
    end
  end
end

require 'sinatra/assetpack/rake'
require "sinatra/activerecord/rake"

require 'rake'

DB_CONFIG = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(DB_CONFIG)

load File.join(File.dirname(__FILE__), 'tasks', 'sphinx.rake')
