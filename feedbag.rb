require 'sinatra'

set :haml, { :attr_wrapper => "\"" }

get '/' do
  haml :home
end

get '/rating/:request_id/:timestamp' do
  @request_id = params[:request_id]
  @timestamp = params[:timestamp]
  haml :rating
end