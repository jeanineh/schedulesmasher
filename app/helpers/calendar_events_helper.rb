
module CalendarEventsHelper

	def self.parse(pathname)
		@calendar_file = ""
		@arrayOfCalendars = []

		# Open the file, passed in as a String to the module
		@calendar_file = File.open(pathname)

		# Parser returns an array of calendars because a single file can have multiple calendars
		@arrayOfCalendars = Icalendar::Calendar.parse(@calendar_file)

		# Iterate through each calendar 
		for calendar in @arrayOfCalendars
			for event in calendar
				# Each event is stored in the allEvents array as an array [<starttime>, <endtime>]
				newEvent = [event.dtstart, event.dtend]
				@allEvents.append(newEvent)
			end
		end

		# Finally, return the nested array of all events for this .ics file
		return @allEvents

	end
end
