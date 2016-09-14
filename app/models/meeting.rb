class Meeting < ActiveRecord::Base
	has_many :team_members
	


	# def self.save_to_db(eventsArray)
	# 	for event in eventsArray
	# end
end