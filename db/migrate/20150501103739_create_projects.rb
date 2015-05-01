class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :app_id
      t.string :branch
      t.string :sha

      t.timestamps null: false
    end
  end
end
