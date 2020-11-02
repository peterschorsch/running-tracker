class SessionsController < ApplicationController
  def new
    redirect_to dashboard_path if current_user
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password]) && @user.is_active?
      session[:user_id] = @user.id

      current_user.check_current_weekly_total_record_upon_login

      current_user.create_user_totals
      current_user.create_weeklong_default_runs

      respond_to do |format|
        format.html { redirect_to dashboard_path, notice: "<h3><strong>Welcome, #{@user.concat_name}!</strong></h3>" }
      end
    else
      flash.now[:alert] = @user.blank? ? "Email or password is invalid" : @user.is_archived? ? "Your account has been marked as inactive" : "Email or password is invalid"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "You have been logged out!"
  end
end
