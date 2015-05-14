class Project < ActiveRecord::Base
  validates :branch_id, presence: true
  validates :sha, presence: true
end
