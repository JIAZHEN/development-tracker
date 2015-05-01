class Release < ActiveRecord::Base
  validates :jira_number, presence: true
  validates :project_id, presence: true
  validates :environment_id, presence: true
  validates :status_id, presence: true
  validates :description, presence: true
  validates :deploy_instruction, presence: true
  validates :rollback_instruction, presence: true
end
