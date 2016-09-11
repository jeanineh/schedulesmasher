#require 'calendar_events_helper.rb'

class Meeting < ActiveRecord::Base

	def self.read_file(filename)
		contents = []
		File.foreach(filename) do |line|
			contents.append(line)
		end
		return contents
	end
end
