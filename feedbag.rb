require 'sinatra'
require 'help_spot'

set :haml, { :attr_wrapper => '"' }

help_spot = HelpSpot.new 'http://support.monkdevelopment.com/api/', 'shane@monkdevelopment.com', 'eYTjj7Z4Ec'

get '/' do
  haml :home
end

get '/rating/:accesskey/:timestamp' do
  @accesskey = params[:accesskey]
  @request = @accesskey[0,5]
  @request_password = @accesskey[5,5]
  @timestamp = params[:timestamp]
  @dump = help_spot.request @request
  @request_history = @dump.request_history
  @auth = "sadly, no"
  if help_spot.authenticated?
    @auth = "HELL YES!"
  end
  haml :rating
end
