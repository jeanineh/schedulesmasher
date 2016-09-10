require 'calendar_events_helper.rb'

class Meeting < ActiveRecord::Base

	def self.read_file(filename)
		contents = []
		return CalendarEventsHelper.parse(filename)
	end
end
