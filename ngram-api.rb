require 'sinatra'
require 'mechanize'
require 'pry'
require './google_ngrams.rb'

class NgramApi < Sinatra::Base
  get '/ngram' do
    JSON.generate(GoogleNgrams.new(params).fetch)
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end