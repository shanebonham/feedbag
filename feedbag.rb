require 'sinatra'

set :haml, { :attr_wrapper => "\"" }

get '/' do
  haml :home
end