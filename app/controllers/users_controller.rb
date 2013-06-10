class UsersController < ApplicationController
  def index
    @page = params[:page] ? params[:page].to_i : 1
    @pages = User.count / 50
    @users = @page > @pages ? User.page(1) : User.page(@page)  
  end
end
