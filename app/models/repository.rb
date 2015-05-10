class Repository < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 50 }

  has_many :branches

  def active_branches
    branches.where(active: 1)
  end
end
