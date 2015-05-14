class Status < ActiveRecord::Base
  WAIT_TO_DEPLOY = 1
  DEPLOYING = 2
  DEPLOYED = 3
  ROLLING_BACK = 4
  ROLLED_BACK = 5

  validates :name, presence: true, length: { maximum: 15 }
end
