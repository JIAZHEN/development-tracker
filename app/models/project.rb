class Project < ActiveRecord::Base
  validates :release_id, presence: true
  validates :branch_id, presence: true
  validates :sha, presence: true
end
