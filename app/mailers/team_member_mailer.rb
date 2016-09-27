class TeamMemberMailer < ApplicationMailer

	def propose_time_msg(team_member, proposed_time)
		@team_member = team_member
		@proposed_time = proposed_time
		mail(:to => team_member.email, :subject => "Proposed Meeting Time")
	end

end
