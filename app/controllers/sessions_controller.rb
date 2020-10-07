class SessionsController < ApplicationController
  def new
    redirect_to dashboard_path if current_user
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password]) && @user.is_active?
      session[:user_id] = @user.id

      # Create All Time Total if not yet currently created
      @all_time_total = AllTimeTotal.create_random_totals(@user.id)

      # Create Yearly Totals if not yet currently created
      @yearly_total = YearlyTotal.create_random_totals(@user.id, @all_time_total.id)

      # Create Monthly Totals if not yet currently created
      @monthly_total = MonthlyTotal.create_random_totals(@user.id, @yearly_total.id, Date.current.beginning_of_month, Date.current.end_of_month)

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
