class CalendarEvent < ActiveRecord::Base
  belongs_to :team_member

  def to_date
    "#{self.start}, #{self.end}"
  end

end
