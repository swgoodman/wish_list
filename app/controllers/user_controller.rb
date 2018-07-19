require './config/environment'

class UsersController < ApplicationController

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/login' do
    erb :'user/login'
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id

      redirect to '/users/#{@user.username}/list'
    else
      erb :'user/login'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id

      erb :':username/list'
    end
  end

  get '/users/:slug/list' do
    if logged_in?
      @user = User.find_by_id(params[:id])
      erb :'user/show_list'
    else
      redirect to '/login'
    end
  end

end
