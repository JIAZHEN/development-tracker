class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :branch_id
      t.string :sha
      t.string :deployment_instruction
      t.string :rollback_instruction

      t.timestamps null: false
    end
  end
end
