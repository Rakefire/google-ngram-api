require 'sinatra'
require 'sinatra/cross_origin'
require 'mechanize'
require './google_ngrams.rb'

class NgramApi < Sinatra::Base
  get '/ngrams' do
    cross_origin
    JSON.generate(GoogleNgrams.new(params).fetch)
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end