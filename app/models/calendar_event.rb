require 'date'

class CalendarEvent < ActiveRecord::Base
  belongs_to :team_member

  scope :future, -> { where("end > ?", DateTime.now) }
  scope :one_week_from_today, -> { where("end < ?", 7.days.from_now) }

  def to_date
    "#{self.start}, #{self.end}"
  end

end
