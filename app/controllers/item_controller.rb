require './config/environment'

class ItemsController < ApplicationController

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/:slug/list/add' do
    @user = User.find_by_slug(params[:slug])
    if logged_in?
      erb :'item/create_item'
    else
      redirect to '/login'
    end
  end
end
