module Modules::TotalRecord
	def of_user(user)
		where(:user => user)
	end

	def unfrozen_records
		where(:frozen_flag => false)
	end

	def frozen_records
		where(:frozen_flag => true)
	end

  	### USED UPON LOGIN TO FREEZE YEARLY TOTALS THAT ARE NOT CURRENT YEARLY ###
	def freeze_total_records_collection
		self.update_all(frozen_flag: true)
	end

end