module UserAuthorization
    extend ActiveSupport::Concern

    def website_viewer_authorization(route = dashboards_path)
      if current_user.is_viewer?
        flash[:alert] = "You are not authorized to do said action."
        redirect_to route
      end
    end
end