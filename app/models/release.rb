class Release < ActiveRecord::Base
  validates :jira_number, presence: true
  validates :environment_id, presence: true
  validates :status_id, presence: true
  validates :description, presence: true
  validates :qa, presence: true

  has_many :projects
end
