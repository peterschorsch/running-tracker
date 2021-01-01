class SessionsController < ApplicationController
  before_action :check_for_logged_in, only: [:root_page, :new]
  #auto_session_timeout_actions

  def root_page
    render layout: "root_screen"
  end

  def new
    render layout: "login_screen"
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password]) && @user.is_active?
      session[:user_id] = @user.id

      @user.check_all_time_total_record_upon_login
      @user.check_current_weekly_total_record_upon_login

      if @user.is_viewer?
        @user.create_website_viewer_runs
        @user.check_past_planned_runs
        @user.check_for_recent_obligations
      else
        @user.create_weeklong_default_runs
      end

      respond_to do |format|
        format.html { redirect_to dashboards_path, notice: "<h3><strong>Welcome, #{@user.concat_name}!</strong></h3>" }
      end
    else
      flash.now[:alert] = @user.blank? ? "Email or password is invalid" : @user.is_archived? ? "Your account has been marked as inactive" : "Email or password is invalid"
      render "new"
    end
  end

  def destroy
    reset_session

    redirect_to login_path, notice: "You have been logged out!"
  end

  # For session timeout
  def active
    render_session_status
  end

  # For session timeout
  def timeout
    render_session_timeout
  end

  private
    def check_for_logged_in
      redirect_to dashboards_path if logged_in?
    end
end
