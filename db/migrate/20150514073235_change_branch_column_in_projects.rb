class ChangeBranchColumnInProjects < ActiveRecord::Migration
  def change
    rename_column :projects, :branch, :branch_id
    change_column :projects, :branch_id, :integer
  end
end
