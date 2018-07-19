require './config/environment'

class ItemsController < ApplicationController

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/:slug/list/add' do
    if logged_in?
      @user = User.find_by_slug(params[:slug])
      erb :'item/create_item'
    else
      redirect to '/login'
    end
  end

  post '/:slug/list/add' do
  @user = User.find_by_slug(params[:slug])
  if logged_in?
    if params[:name] == "" || params[:link] == "" || params[:price] == "" || params[:category] == ""
      redirect to "/#{@user.slug}/list/add"
    else
      @tweet = current_user.tweets.build(content: params[:content])
      if @tweet.save
        redirect to "/tweets/#{@tweet.id}"
      else
        redirect to "/tweets/new"
      end
    end
  else
    redirect to '/login'
  end
end
end
