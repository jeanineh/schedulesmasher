#require 'calendar_events_helper.rb'
require 'icalendar'

class Meeting < ActiveRecord::Base

	def self.read_file(filename)
		contents = []
		cal_file = File.open(filename)
		events = Icalendar::Event.parse(cal_file)
		event = events.first
		return event
	end
end
