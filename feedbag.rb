require 'sinatra'
require 'help_spot'

set :haml, { :attr_wrapper => '"' }

help_spot = HelpSpot.new 'http://support.monkdevelopment.com/api/', 'shane@monkdevelopment.com', 'eYTjj7Z4Ec'

helpers do
  def get_reply(request_history, timestamp)
    stuff = ''
    request_history.each do |x|
      if (x.dtGMTChange.delete(' ') == timestamp.delete(' ')) && !x.tLog
        stuff = stuff + "<li>#{x.dtGMTChange} - #{x.xRequestHistory}</li>\n"
      end
    end
    return stuff
  end
end

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
  haml :rating
end
