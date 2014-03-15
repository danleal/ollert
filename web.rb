require 'sinatra'
require 'haml'

DEV_SECRET = "0942956f9eeea22688d8717ec9e12955"
APP_NAME = "ollert"

class Ollert < Sinatra::Base
  get '/' do
    @secret = DEV_SECRET
    haml :landing
  end

  get '/connect' do
    "Holy cow I received the following token: #{params[:token]}"
  end
end
