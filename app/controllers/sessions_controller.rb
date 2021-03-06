class SessionsController < ApplicationController
  include ControllerNotice

  before_action :check_for_logged_in, only: [:root_page, :new]
  auto_session_timeout_actions

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
      session[:administrator] = @user.is_admin?
      session[:website_viewer] = @user.is_viewer?
      session[:obligation_color_id] = ObligationColor.first.id

      ### UPDATE LAST LOGIN FIELD ###
      @user.update_last_login

      ### TOTAL RECORDS CHECK FOR ALL USERS ###
      @user.check_for_total_records_upon_login

      if session[:website_viewer]
        ### CREATE/UPDATE RUNS FOR WEBSITE VIEWER ###
        @user.website_viewer_methods_check_upon_login
        @user.dynamically_create_website_viewer_races
      else
        ### DELETE PLANNED RUNS FROM PREVIOUS MONTHS ###
        @user.check_for_previous_planned_runs
        ### CREATE PLANNED RUNS FOR THIS WEEK - TESTING ###
        @user.create_weeklong_default_runs
      end

      respond_to do |format|
        format.html { redirect_to dashboards_path, notice: "<h3>" + bold_text("Welcome, #{@user.concat_name}!") + "</h3>" }
      end
    else
      alert_message = "Email and/or Password is invalid."
      alert_message = "Your Account has been marked as inactive." if not @user.blank? and @user.is_archived?
      flash[:alert] = alert_message

      redirect_to login_path
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
    reset_session
    render_session_timeout
  end

  private
    def check_for_logged_in
      redirect_to dashboards_path if logged_in?
    end
end
