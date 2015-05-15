class Release < ActiveRecord::Base
  validates :jira_number, presence: true
  validates :environment_id, presence: true
  validates :status_id, presence: true
  validates :description, presence: true
  validates :qa, presence: true

  has_many :projects
  belongs_to :status

  STATUS_TO_COLOUR = {
    Status::WAIT_TO_DEPLOY => "primary",
    Status::DEPLOYING => "info",
    Status::DEPLOYED => "success",
    Status::ROLLING_BACK => "danger",
    Status::ROLLED_BACK => "warning"
  }

  def status_colour
    STATUS_TO_COLOUR[status.id]
  end
end
