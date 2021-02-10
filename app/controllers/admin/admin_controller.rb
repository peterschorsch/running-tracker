class Admin::AdminController < ApplicationController
	include ControllerNotice
	include UserAuthorization

	before_action do
		website_viewer_authorization(dashboards_path)
	end
end