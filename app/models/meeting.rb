
class Meeting < ActiveRecord::Base
	require 'icalendar'
	#include CalendarEventsHelper::Calendar

	# gets an array of calendar events
	def self.read_file(filename)
		uploaded_file = File.open(filename)
		events = Icalendar::Event.parse(uploaded_file)
		#event = events.first
		#return event

		allEvents = []
		# Iterate through each calendar 
		for event in events
			# Each event is stored in the allEvents array as an array [<starttime>, <endtime>]
			newEvent = [event.dtstart, event.dtend]
			allEvents.append(newEvent)
		end

		return allEvents
	end


	def self.save_to_db(eventsArray)
		for event in eventsArray
	end
end
