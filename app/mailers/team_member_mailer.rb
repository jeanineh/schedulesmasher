class TeamMemberMailer < ApplicationMailer

	def propose_time_msg(team_member)
		@team_member = team_member
		mail(:to => team_member.email, :subject => "Proposed Meeting Time")
	end

end
