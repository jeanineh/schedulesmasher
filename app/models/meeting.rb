class Meeting < ActiveRecord::Base
	has_many :team_members
	accepts_nested_attributes_for :team_members

	def get_team_members_by_hour(given_date)
		count = 0
		team_members.each do |member|
			member.calendar_events.each do |event|
				if(given_date.hour >= event.start.hour)&&(given_date.hour < event.end.hour)&&(given_date.day==event.start.day)
					count = count+1
				end
			end
		end
		return count
	end

	def getMembersByTime(given_date)
		m = Array.new 
		team_members.each do |member|
			member.calendar_events.each do |event|
				if(given_date.hour >= event.start.hour)&&(given_date.hour < event.end.hour)&&(given_date.day==event.start.day)
					m.push(member.name)
				end
			end
		end
		available_members = Array.new
		team_members.each do |member|
			if not m.include?(member.name)
				available_members.push(member.name)
			end
		end

		m_string = ""
		if available_members.length == 0
			return "Nobody is available at this time."
		end
		available_members.each do |name|
			if name==available_members.last && available_members.length > 1
				m_string = m_string + "and "+name
			elsif available_members.length == 1
				return name+" is available at this time."
			else
				m_string = m_string + name+"\n"
			end
		end
		return m_string+" are all available at this time."
	end

	# def self.save_to_db(eventsArray)
	# 	for event in eventsArray
	# end
end