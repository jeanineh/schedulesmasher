class CalendarEvent < ActiveRecord::Base
  belongs_to :team_member

  def name
    "#{self.start}, #{self.end}"
  end

end
