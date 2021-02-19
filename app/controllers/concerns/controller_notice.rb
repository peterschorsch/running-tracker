module ControllerNotice
    extend ActiveSupport::Concern

    def bold_text(text)
      	"<strong>#{text}</strong>"
    end

    def create_notice(text)
      	bold_text(text) + " was successfully created."
    end

    def update_notice(text)
      	bold_text(text) + " was successfully updated."
    end

    def remove_notice(text)
      	bold_text(text) +  " was successfully removed."
    end

    # February 9, 2021
    def date_field(date)
		date.strftime("%B %-d, %Y")
    end

    # Feb. 9-14
    def shortened_date_range(week_start, week_end)
      week_start.strftime("%-b. %-d") + "-" + week_end.strftime("%-d")
    end

end
