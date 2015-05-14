class Project < ActiveRecord::Base
  validates :branch_id, presence: true
  validates :sha, presence: true
  validates :repository_id, presence: true
end
