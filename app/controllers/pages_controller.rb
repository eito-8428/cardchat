class PagesController < ApplicationController
  def index
    @user = current_user
    @users = User.all
    
  end
end
