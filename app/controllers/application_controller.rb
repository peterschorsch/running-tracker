class ApplicationController < ActionController::Base
	helper_method :logged_in?, :current_user

	def dashboard
		@obligations = Obligation.all.includes(:state)
	end

	def current_user
		if session[:user_id]
			@current_user = User.find(session[:user_id])
		end
	end

	def logged_in?
		!!current_user
	end

	def authorized
		redirect_to login_path unless logged_in?
	end
end
