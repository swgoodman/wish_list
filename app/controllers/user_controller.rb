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
    @user = User.find_by(:name => params[:name])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id

      redirect to "/users/#{@user.name}/list"
    else
      erb :'user/login'
    end
  end

  post '/signup' do
    if params[:name] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.new(:name => params[:name], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id

      redirect to '/users/@user.slug/list'
    end
  end

  get '/users/:slug/list' do
    @user = User.find_by_slug(params[:slug])
    erb :'user/show_list'
  end

end
