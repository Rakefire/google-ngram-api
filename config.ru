require 'rubygems'
require 'bundler'
Bundler.require

root_dir = File.dirname(__FILE__)
app_file = File.join(root_dir, 'ngram-api.rb')
require app_file

set :environment, ENV['RACK_ENV'].to_sym
set :root,        root_dir
set :app_file,    app_file

set :allow_origin, :any
set :allow_methods, [:get, :post, :options]
set :allow_credentials, true
set :max_age, "1728000"
set :expose_headers, ['Content-Type']

disable :run

NgramApi.run!