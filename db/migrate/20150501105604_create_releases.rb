class CreateReleases < ActiveRecord::Migration
  def change
    create_table :releases do |t|
      t.string :jira_number
      t.integer :project_id
      t.integer :environment_id
      t.integer :status_id
      t.string :description
      t.string :deploy_instruction
      t.string :rollback_instruction

      t.timestamps null: false
    end
  end
end
