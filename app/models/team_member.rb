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

  # takes a team member, gets their calendar, turns into dict with key date and array of (start, end, team_member_id) times
  def self.calendar_to_dict(team_member)
    events = team_member.calendar_events.all
    cal_dict = Hash.new
    events.each do |event|
      start_datetime = event.name.split(",")[0] # datetime for start of event. ex: 2016-09-18 16:00:00 UTC
      end_datetime = event.name.split(",")[1] # datetime for end of event

      date = start_datetime.split(" ")[0] # just the date for the event. ex: 2016-09-18
      # time is in UTC format
      start_time = start_datetime.split(" ")[1] # just the time for the event ex: 16:00
      end_time = end_datetime.split(" ")[1]
      times = [start_time, end_time, team_member.id] # just the start and end times for the event. 

      if !cal_dict[date].nil?
        curr_dates = cal_dict[date]
        curr_dates.append(times)
        cal_dict[date] = curr_dates
      else 
        curr_dates = []
        curr_dates.append(times)
        cal_dict[date] = curr_dates
      end
    end

    return cal_dict
  end


  # finds all members in a meeting, smashes their calendars together
  def self.smash(meeting)
    smashed_cal = Hash.new
    meeting.team_members.each do |team_member|
      if !smashed_cal.empty? # a partially smashed calendar exists
        team_cal = calendar_to_dict(team_member)
        # find keys (dates) already in the partially smashed calendar, add team member's events
        # if there aren't any events on that date in the smashed cal, add it as a new key-val pair
        team_cal.each do |key, value| 
          if !smashed_cal[key].nil?
            smash_val = smashed_cal[key]
            smash_val.append(team_cal[key])
            smashed_cal[key] = smash_val
          else 
            smashed_cal[key] = value
          end
        end
      else
        smashed_cal = calendar_to_dict(team_member)
      end
    end
    return smashed_cal
  end

  # create and save calendar events for team member
  def save_events(events)
    events.each do |event|
      new_calendar_event = CalendarEvent.new
      new_calendar_event.team_member_id = self.id 
      # start time
      new_calendar_event.start = event[0]
      # end time
      new_calendar_event.end = event[1]
      new_calendar_event.save
    end
  end


  def proper_name
    "#{name}"
  end
end

