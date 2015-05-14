class ChangeAppIdInProjects < ActiveRecord::Migration
  def change
    rename_column :projects, :app_id, :repository_id
  end
end
