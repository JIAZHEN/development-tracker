class Project < ActiveRecord::Base
  validates :branch, presence: true
  validates :sha, presence: true
  validates :app_id, presence: true
end
