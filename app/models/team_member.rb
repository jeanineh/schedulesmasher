class TeamMember < ActiveRecord::Base
  require 'icalendar'
  #include CalendarEventsHelper::Calendar

  belongs_to :meeting
  has_many :calendar_events

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

  def save_events(events)
    events.each do |event|
      new_calendar_event = CalendarEvent.new
      new_calendar_event.team_member_id = self.id 
      new_calendar_event.start = event[0]
      new_calendar_event.end = event[1]
      new_calendar_event.save
    end
  end


  def proper_name
    "#{name}"
  end

  end
