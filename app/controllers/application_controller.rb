class ApplicationController < ActionController::Base
	# For session timeout
	auto_session_timeout 10.minutes

	around_action :set_time_zone, if: :current_user

	helper_method :logged_in?, :current_user

	def current_user
		@current_user = session[:user_id] ? User.find(session[:user_id]) : nil
	end

	def logged_in?
		!!current_user
	end

	private
	def set_time_zone(&block)
	  Time.use_zone(current_user.time_zone, &block)
	end

end
