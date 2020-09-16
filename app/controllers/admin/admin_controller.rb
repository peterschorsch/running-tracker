class Admin::AdminController < ApplicationController
	before_action :authorized?

	private
	  def authorized?
		if current_user && (current_user.is_user? || current_user.is_archived?)
	  		session[:user_id] = current_user.id || nil
	    	flash[:alert] = "You are not authorized to do said action."
	    	redirect_to dashboard_path
	    end
	  end

end