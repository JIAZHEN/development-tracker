class Release < ActiveRecord::Base
  validates :jira_number, presence: true
  validates :environment_id, presence: true
  validates :status_id, presence: true
  validates :description, presence: true
  validates :qa, presence: true

  has_many :projects
  belongs_to :status
  belongs_to :environment

  STATUS_TO_COLOUR = {
    Status::WAIT_TO_DEPLOY => "warning",
    Status::DEPLOYING => "info",
    Status::DEPLOYED => "success",
    Status::ROLLBACK => "danger"
  }

  def status_colour
    STATUS_TO_COLOUR.fetch(status.id, "active")
  end
end
