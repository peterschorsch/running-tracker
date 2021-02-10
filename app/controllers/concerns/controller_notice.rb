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

    # 2/9
    def shortened_date_field(date)
		date.strftime("%B %-d, %Y")
    end
end
