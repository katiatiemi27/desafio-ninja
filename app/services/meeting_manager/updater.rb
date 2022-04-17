module MeetingManager
  class Updater < ApplicationManager::Updater
    private

    def execute_update
      meeting = Meeting.find_by!(id: id)

      initial = @params[:initial_time].presence || meeting.initial_time.strftime('%H:%M')
      final = @params[:final_time].presence || meeting.final_time.strftime('%H:%M')
      raise Exceptions::InvalidHour if initial > final
      raise Exceptions::NotComercialHour unless initial.between?('09:00', '18:00') && 
                                                final.between?('09:00', '18:00')
      raise Exceptions::NonExistentRoom if @params[:room].present? && (@params[:room].to_i <= 0 || @params[:room].to_i > MeetingManager::Creator::MAX_ROOM)

      verify_availability(@params[:date].presence || meeting.date, @params[:initial_time].presence || meeting.initial_time.strftime('%H:%M'),
                          @params[:final_time].presence || meeting.final_time.strftime('%H:%M'), @params[:room].presence || meeting.room)

      meeting.update!(@params)
      meeting
    end

    def verify_availability(date, initial, final, room)
      meetings = Meeting.where(room: room, date: date).where.not(id: id)
      found = meetings.any? { |m| m.initial_time.strftime('%H:%M').between?(initial, final) || m.final_time.strftime('%H:%M').between?(initial, final) }
      raise Exceptions::RoomNotAvailable if found
    end

    def initialize(id, params)
      super(id)
      @params = params.slice(:room, :date, :initial_time, :final_time, :name)
    end
  end
end
