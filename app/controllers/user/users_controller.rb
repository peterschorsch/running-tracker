class User::UsersController < ApplicationController
  include ControllerNotice
  include UserAuthorization

  before_action :check_user_id

  private
  def check_user_id
    if current_user.id != params[:user_id].to_i
      flash[:alert] = "Access Denied."
      redirect_to dashboards_path
    end
  end

end
