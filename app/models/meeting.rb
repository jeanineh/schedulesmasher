class Meeting < ActiveRecord::Base
	has_many :team_members
	accepts_nested_attributes_for :team_members


	# def self.save_to_db(eventsArray)
	# 	for event in eventsArray
	# end
end