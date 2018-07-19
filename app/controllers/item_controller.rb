require './config/environment'

class ItemsController < ApplicationController

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
end
