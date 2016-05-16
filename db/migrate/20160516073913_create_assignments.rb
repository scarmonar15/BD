class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.date :limit_date
      t.string :description
      t.float :grade

      t.timestamps
    end
  end
end
