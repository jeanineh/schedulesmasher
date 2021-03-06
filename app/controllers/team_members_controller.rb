class TeamMembersController < ApplicationController
  before_action :set_team_member, only: [:show, :edit, :update, :destroy]
  # GET /team_members
  # GET /team_members.json
  def index
    @team_members = TeamMember.all
  end

  # GET /team_members/1
  # GET /team_members/1.json
  def show
    @events = TeamMember.smash(@team_member.meeting)
  end

  # GET /team_members/new
  def new
    @team_member = TeamMember.new
  end

  # GET /team_members/1/edit
  def edit
  end

  # POST /team_members
  # POST /team_members.json
  def create
    @team_member = TeamMember.new(team_member_params)
    uploaded_file = params[:team_member][:file].tempfile
    eventsArray = TeamMember.read_file(uploaded_file)
    @team_member.save_events(eventsArray)


    respond_to do |format|
      if @team_member.save

        uploaded_file = params[:team_member][:file].path

        # TeamMemberMailer.propose_time_msg(@team_member, "2:00 pm").deliver

        eventsArray = TeamMember.read_file(uploaded_file)
        @team_member.save_events(eventsArray)
        format.html { redirect_to @team_member.meeting, notice: 'Calendar was successfully smashed! Please select a time on the schedule when done!' }
        format.json { render :show, status: :created, location: @team_member }
      else
        format.html { render :new }
        format.json { render json: @team_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /team_members/1
  # PATCH/PUT /team_members/1.json
  def update
    respond_to do |format|
      if @team_member.update(team_member_params)
        format.html { redirect_to @team_member, notice: 'Team member was successfully updated.' }
        format.json { render :show, status: :ok, location: @team_member }
      else
        format.html { render :edit }
        format.json { render json: @team_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /team_members/1
  # DELETE /team_members/1.json
  def destroy
    @team_member.destroy
    respond_to do |format|
      format.html { redirect_to team_members_url, notice: 'Team member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def uploader
    @team_member = TeamMember.find(params[:id])
    uploaded_file = params[:file]
    eventsArray = TeamMember.read_file(uploaded_file)
    @team_member.save_events(eventsArray)
    respond_to do |format|
      format.html { redirect_to @team_member, notice: 'Schedule successfully uploaded.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team_member
      @team_member = TeamMember.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_member_params
      params.require(:team_member).permit(:name, :email, :meeting_id)
    end
end
