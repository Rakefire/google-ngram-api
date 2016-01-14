require 'sinatra/base'
require 'pry'
require 'mechanize'
require './google_ngrams.rb'

class NgramApi < Sinatra::Base

  use Rack::Cors do
    allow do
      origins  "*"
      resource "*", headers: :any, methods: [:get, :options]
    end
  end

  before do
    response["Content-Type"] = "application/json"
  end

  get '/ngrams' do
    JSON.generate(GoogleNgrams.new(params).fetch)
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end