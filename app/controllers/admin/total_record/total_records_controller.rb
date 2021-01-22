class Admin::TotalRecord::TotalRecordsController < Admin::AdminController
  def index
    @yearly_totals = current_user.yearly_totals.order_by_recent_year.includes(:monthly_totals)
    @weekly_totals = current_user.weekly_totals.order_by_recent_week
  end
end
