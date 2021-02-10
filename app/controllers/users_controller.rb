class UsersController < ApplicationController
  include ControllerNotice
  include UserAuthorization

  before_action :set_user
  before_action only: [:update, :update_password] do
    website_viewer_authorization(edit_user_path(current_user))
  end

  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  # GET /users/1/edit
  def edit
    @website_viewer = User.return_website_viewer
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if current_user.update(user_params)
        format.html { redirect_to edit_user_path(current_user), notice: update_notice("Your Profile") }
        format.json { render :edit, status: :ok, location: current_user }
      else
        format.html { render :edit }
        format.json { render json: current_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_password
    respond_to do |format|
      if current_user.update_with_password(user_password_params)
        format.html { redirect_to edit_user_path(current_user), notice: update_notice("Your Password") }
      else
        format.html { render :edit }
        format.json { render json: current_user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
      ### IF USER DOESN'T MATCH CURRENT USER OR IS ARCHIVED
      if current_user != @user || current_user.is_archived?
        flash[:alert] = "Access Denied."
        redirect_to edit_user_path(current_user)
      end
    end

    def handle_record_not_found
      # Send it to the view that is specific for User not found
      flash[:alert] = "Record not Found."
      redirect_to dashboards_path
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :default_city, :default_state, :time_zone, :password_digest)
    end
end
