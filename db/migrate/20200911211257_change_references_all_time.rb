class ChangeReferencesAllTime < ActiveRecord::Migration[5.2]
  def change
  	add_belongs_to :users, :all_time_totals, foreign_key: true
  end
end
