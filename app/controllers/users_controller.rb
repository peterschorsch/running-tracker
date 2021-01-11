class UsersController < ApplicationController
  before_action :authorized?
  before_action :viewer_authorization, only: [:update, :update_password]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  # GET /users/1/edit
  def edit
  end


  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if current_user.update(user_params)
        format.html { redirect_to edit_user_path(current_user), notice: 'Your Profile was successfully updated.' }
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
        format.html { redirect_to edit_user_path(current_user), notice: "Your password was successfully updated." }
      else
        format.html { render :edit }
        format.json { render json: current_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def handle_record_not_found
    # Send it to the view that is specific for User not found
    flash[:alert] = "Record not Found"
    redirect_to dashboards_path
  end

  private
    def authorized?
      @user = User.find(params[:id])
      ### IF USER DOESN'T MATCH CURRENT USER OR IS ARCHIVED
      if current_user != @user || current_user.is_archived?
        flash[:alert] = "You are not authorized to do said action."
        redirect_to dashboards_path
      end
    end

    def viewer_authorization
      if current_user.is_viewer?
        flash[:alert] = "You are not authorized to do said action."
        redirect_to edit_user_path(current_user)
      end
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :time_zone, :password_digest)
    end
end
