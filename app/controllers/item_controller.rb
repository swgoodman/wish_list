require 'rack-flash'
require './config/environment'


class ItemsController < ApplicationController

  use Rack::Flash, :sweep => true

# Configures location of files.
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

# Sign Up GET Route - Authenticates user and renders 'New' Form.
  get '/:slug/list/add' do
    if logged_in?
      @user = User.find_by_slug(params[:slug])
      erb :'item/create_item'
    else
      redirect to '/login'
    end
  end

# Sign Up GET Route - Authenticates user and renders 'New' Form.
  post '/:slug/list/add' do
    if logged_in?
      if Item.find_by_slug(params[:name].gsub(" ", "-").downcase) || params[:name] == "" || params[:link] == "" || params[:price] == "" || params[:category] == ""
        flash[:message] = "There was an error. Please make sure all fields are filled out."
        redirect to "/#{current_user.slug}/list/add"
      else
        @category = Category.find_or_create_by(name: params[:category])
        @item = current_user.items.build(name: params[:name], link: params[:link], price: params[:price], category_id: @category.id)

        if @item.save
          flash[:message] = "Successfully created item."
          redirect to "/#{current_user.slug}/list"
        else
          flash[:message] = "There was an error. Please make sure all fields are filled out."
          redirect to "/#{current_user.slug}/list/add"
        end
      end
    else
      redirect to '/login'
    end
  end

# Show Item GET Route - Shows item details with links to Edit or Delete.
  get '/*/list/:slug' do
    if logged_in?
      @item = Item.find_by_slug(params[:slug])
      erb :'item/show_item'
    else
      redirect to "/login"
    end
  end

#Edit Item GET Route - Renders edit form.
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

#Edit Item PATCH Route - Accepts updated item params and updates item details.
  patch '/*/list/:slug' do
    if logged_in?
      @item = Item.find_by_slug(params[:slug])
      if params[:name] == "" || params[:link] == "" || params[:price] == "" || params[:category] == ""
        flash[:message] = "There was an error. Please make sure all fields are filled out."
        redirect to "/#{current_user.slug}/list/#{@item.slug}/edit"
      else @item && @item.user == current_user
        @category = Category.find_or_create_by(name: params[:category])
        if @item.update(name: params[:name], link: params[:link], price: params[:price], category_id: @category.id)
          flash[:message] = "Successfully edited item."
          redirect to "/#{current_user.slug}/list/#{@item.slug}"
        else
          flash[:message] = "There was an error. Please make sure all fields are filled out."
          redirect to "/#{current_user.slug}/list/#{@item.slug}/edit"
        end
      end
    else
      redirect to "/login"
    end
  end

# Delete Item POST Route - Confirms user and deletes item from DB.
  delete '/*/list/:slug/delete' do
    if logged_in?
      @item = Item.find_by_slug(params[:slug])
        if @item && @item.user == current_user
          @item.delete
          flash[:message] = "Successfully deleted item."
          redirect to "/#{current_user.slug}/list"
        end
    else
      redirect to '/login'
    end
  end

end
