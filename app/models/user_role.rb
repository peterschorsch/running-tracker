class UserRole < ApplicationRecord
	has_many :users, dependent: :destroy

	validates :name, presence: true

	scope :return_admin_user_role, -> {
		find_by(:administrator => true, :user => false, :website_viewer => false)
	}

	scope :return_user_role, -> {
		find_by(:user => true, :website_viewer => false, :administrator => false)
	}

	scope :return_website_viewer_role, -> {
		find_by(:website_viewer => true, :user => false, :administrator => false)
	}

end
