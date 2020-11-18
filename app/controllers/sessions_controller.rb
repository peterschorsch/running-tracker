class SessionsController < ApplicationController
  before_action :check_for_logged_in, only: [:root_page, :new]

  def root_page
    render layout: "root_screen"
    puts logged_in?
  end

  def new
    render layout: "login_screen"
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password]) && @user.is_active?
      session[:user_id] = @user.id

      @user.check_current_weekly_total_record_upon_login

      @user.create_weeklong_default_runs

      respond_to do |format|
        format.html { redirect_to dashboards_path, notice: "<h3><strong>Welcome, #{@user.concat_name}!</strong></h3>" }
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

  private
    def check_for_logged_in
      redirect_to dashboards_path if logged_in?
    end
end
