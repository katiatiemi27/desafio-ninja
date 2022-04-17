class MeetingsController < ApplicationController
  def show
    meeting = MeetingManager::Shower.new(params[:id])
    render json: meeting.build
  end

  def create
    meeting = MeetingManager::Creator.new(params[:room], params[:date].to_date, params[:initial_time].to_time, params[:final_time].to_time, params[:name])
    render json: meeting.create
  end

  def update
    meeting = MeetingManager::Updater.new(params[:id], params.permit(:room, :date, :initial_time, :final_time, :name))
    render json: meeting.update
  end

  def index
    meetings = MeetingManager::Lister.new(filters)
    render json: meetings.build
  end

  def destroy
    meeting = MeetingManager::Destroyer.new(params[:id])
    render json: meeting.destroy
  end

  private

  def filters
    {
      name: params[:name],
      date: params[:date],
      room: params[:room]
    }
  end
end
