class CreateReleases < ActiveRecord::Migration
  def change
    create_table :releases do |t|
      t.string :jira_number
      t.integer :environment_id
      t.integer :status_id
      t.string :description
      t.string :qa
      t.string :dev

      t.timestamps null: false
    end
    add_index :releases, :jira_number
    add_index :releases, :environment_id
    add_index :releases, :status_id
    add_index :releases, :description
    add_index :releases, :qa
    add_index :releases, :dev
  end
end
