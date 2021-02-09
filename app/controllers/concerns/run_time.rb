module RunTime
    extend ActiveSupport::Concern

    def set_run_time_fields(current_user, hours, minutes, seconds)
      	### Also, converts and sets hours, minutes, seconds to just seconds ###
    	@run.set_necessary_run_fields(current_user, hours, minutes, seconds)
    end
end