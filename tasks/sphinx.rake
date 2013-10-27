desc 'environment dummy task'
task :environment, [:env] => 'bundler:setup' do |cmd, args|
  require 'active_support'
  require 'active_support/dependencies'
  require 'thinking_sphinx'
  ENV["RACK_ENV"] = args[:env] || "development"
  require 'sinatra/activerecord'
  require 'sinatra/assetpack'
  require File.join(File.dirname(__FILE__), '..', 'opa_app')
end

begin
  require 'thinking_sphinx/tasks'
rescue LoadError
  puts "You can't load Thinking Sphinx tasks unless the thinking-sphinx gem is installed."
end