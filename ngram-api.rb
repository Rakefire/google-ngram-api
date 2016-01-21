require 'sinatra/base'
require 'mechanize'
require './google_ngrams.rb'

class NgramApi < Sinatra::Base
  use Rack::Logger
  use Rack::Cors do
    allow do
      origins  "*"
      resource "*", headers: :any, methods: [:get, :options]
    end
  end
  
  helpers do
    def logger
      request.logger
    end
  end

  before do
    response["Content-Type"] = "application/json"
  end

  get '/ngrams' do
    logger.info GoogleNgramsUrlBuilder.new(params).url

    JSON.generate(first_timeseries(GoogleNgrams.new(params).fetch))
  end

  private

  def first_timeseries(results)
    results.first["timeseries"]
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end