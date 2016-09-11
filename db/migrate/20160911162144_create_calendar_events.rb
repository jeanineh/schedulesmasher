class CreateCalendarEvents < ActiveRecord::Migration
  def change
    create_table :calendar_events do |t|
      t.datetime :start
      t.datetime :end
      t.int :team_member_id

      t.timestamps null: false
    end
  end
end
