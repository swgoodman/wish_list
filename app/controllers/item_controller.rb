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
  if logged_in?

    if params[:name] == "" || params[:link] == "" || params[:price] == "" # || params[:category] == ""
      redirect to "/#{current_user.slug}/list/add"
    else

      @item = current_user.item.build(name: params[:name], link: params[:link], price: params[:price])
      @item.category_id = Category.find_or_create_by(name: params[:category][:name])
      if @item.save
        redirect to "/#{current_user.slug}/list"
      else
        redirect to "/#{current_user.slug}/list/add"
      end
    end
  else
    redirect to '/login'
  end
end
end
