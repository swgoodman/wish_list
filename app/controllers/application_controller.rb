require './config/environment'

class ApplicationController < Sinatra::Base

# Configures location of files.
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'

    enable :sessions
    set :session_secret, "talk_the_talk"
  end

# Index GET Route - Renders 'Home' page.
  get "/" do
    erb :index
  end

# Helper methods - Authenticate current users.
  helpers do

    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
  end

end
