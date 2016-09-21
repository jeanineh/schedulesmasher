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

	# def self.save_to_db(eventsArray)
	# 	for event in eventsArray
	# end
end