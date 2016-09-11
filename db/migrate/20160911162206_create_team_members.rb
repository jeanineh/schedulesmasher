class CreateTeamMembers < ActiveRecord::Migration
  def change
    create_table :team_members do |t|
      t.string :name
      t.string :email
      t.int :meeting_id

      t.timestamps null: false
    end
  end
end
