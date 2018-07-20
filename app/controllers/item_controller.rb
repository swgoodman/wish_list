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

    if params[:name] == "" || params[:link] == "" || params[:price] == ""# || params[:item[:category_id] == ""
      redirect to "/#{current_user.slug}/list/add"
    else
      @item = current_user.item.build(name: params[:name], link: params[:link], price: params[:price])

      if params[:category][:name] == ""
        redirect to "/#{current_user.slug}/list/add"
      else
        @item.category_id = Category.find_or_create_by(name: params[:category][:name])
      end

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

  get '/*/list/:slug' do
    if logged_in?
      @item = Item.find_by_slug(params[:slug])
      erb :'item/show_item'
    else
      redirect to "/login"
    end
  end

  get '/*/list/:slug/edit' do
    if logged_in?
      @item = Item.find_by_slug(params[:slug])
      if @item && @item.user == current_user
        erb :'item/edit_item'
      else
        redirect to "/#{current_user.slug}/list"
      end
    else
      redirect to "/login"
    end
  end

  patch '/*/list/:slug' do
    if logged_in?
      @item = Item.find_by_slug(params[:slug])
      if params[:name] == "" || params[:link] == "" || params[:price] == ""
        redirect to "/#{current_user.slug}/list/#{@item.slug}/edit"
      else @item && @item.user == current_user
        if @item.update(name: params[:name], link: params[:link], price: params[:price])
          redirect to "/#{current_user.slug}/list/#{@item.slug}"
        else
          redirect to "/#{current_user.slug}/list/#{@item.slug}/edit"
        end
      end
    else
      redirect to "/login"
    end
  end

  delete '/*/list/:slug/delete' do
    if logged_in?
      @item = Item.find_by_slug(params[:slug])
        if @item && @item.user == current_user
          @item.delete
        end
      redirect to "/#{current_user.slug}/list"
    else
      redirect to '/login'
    end
  end

end
