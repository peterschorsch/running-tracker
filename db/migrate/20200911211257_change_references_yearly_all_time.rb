class ChangeReferencesYearlyAllTime < ActiveRecord::Migration[5.2]
  def change
  	add_reference :yearly_totals, :all_time_total, index: true, foreign_key: true

  	add_belongs_to :users, :all_time_totals, foreign_key: true
  end
end
