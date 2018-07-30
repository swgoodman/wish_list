require 'rack-flash'
require './config/environment'

class UsersController < ApplicationController

  use Rack::Flash

# Configures location of files.
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

# Log In Get Route - Renders log in.
  get '/login' do
    erb :'user/login'
  end

# Log In POST Route - Authenticates and updates session.
  post '/login' do
    @user = User.find_by(:name => params[:name])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/#{@user.slug}/list"
    else
      erb :'user/login'
    end
  end

# Sign Up POST Route - Validates and creates new users.
  post '/signup' do
    if User.find_by(:name => params[:name]) || params[:name] == "" || params[:email] == "" || params[:password] == ""
      flash[:message] = "There was an error. Please make sure all fields are filled out."
      erb :'index'
    else
      @user = User.new(:name => params[:name], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id

      flash[:message] = "Welcome to Wish List!"
      redirect to "/#{@user.slug}/list"
    end
  end

# List GET - Authenticates and renders users wish list overview
  get '/:slug/list' do
    @user = current_user
      if logged_in?
        @items = current_user.items.all
        erb :'user/show_list'
      else
        redirect to '/login'
      end
    end

# Log Out GET - Clears the session and logs out.
  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end
end
