require 'sinatra'
require 'help_spot'
require 'data_mapper'
require 'haml'

set :haml, { :attr_wrapper => '"' }

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/feedbag.db")

class Rating
  include DataMapper::Resource
  property :id, Serial
  property :rating, Enum[:good, :okay, :bad]
  property :agent, String
  property :request, String
  property :request_password, String
  property :reply, String
  property :feedback, String
  property :created_at, DateTime
end

DataMapper.finalize.auto_upgrade!

# helpers do
#   def get_reply(request, timestamp)
#     help_spot = HelpSpot.new 'http://support.monkdevelopment.com/api/', 'shane@monkdevelopment.com', 'eYTjj7Z4Ec'
#     response = help_spot.request request
#     request_history = response.request_history
#     stuff = ''
#     request_history.each do |x|
#       if (x.dtGMTChange.delete(' ') == timestamp.delete(' ')) && !x.tLog
#         stuff = x.xRequestHistory
#       end
#     end
#     return stuff
#   end
# end

get '/' do
  haml :home
end

get '/rate/:accesskey/:rating' do
  @accesskey = params[:accesskey]
  r = Rating.new
  r.rating = params[:rating]
  r.request = @accesskey[0,5]
  r.request_password = @accesskey[5,5]
  r.created_at = Time.now
  r.save
  redirect "/rating/#{@accesskey}/#{r.id}"
end

get '/rating/:accesskey/:id' do
  @rating = Rating.get params[:id]
  haml :feedback
end

put '/rating/:id' do
  r = Rating.get params[:id]
end
