class Meeting < ActiveRecord::Base

	def self.read_file(file)
		contents = []
		File.open(file) do |f|
			f.each_line do |line|
				contents.append(line)
			end
		end
	end
end
