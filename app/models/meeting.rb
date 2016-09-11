class Meeting < ActiveRecord::Base
	require 'icalendar'
	#include CalendarEventsHelper::Calendar

	# gets an array of calendar events
	def self.read_file(filename)
		uploaded_file = File.open(filename)
		events = Icalendar::Event.parse(uploaded_file)
		event = events.first
		return event
	end
end
