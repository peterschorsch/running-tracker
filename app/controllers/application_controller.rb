class ApplicationController < ActionController::Base
	helper_method :logged_in?, :current_user
	before_action :authorized?

	def current_user
		@current_user = session[:user_id] ? User.find(session[:user_id]) : nil
	end

	def logged_in?
		!!current_user
	end


	private
	def authorized?
		if current_user.nil?
			redirect_to login_path
		else
			redirect_to login_path if current_user.is_archived?
		end
	end
end
