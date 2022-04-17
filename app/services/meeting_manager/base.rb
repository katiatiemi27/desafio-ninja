module MeetingManager
  class Base < ApplicationManager::Updater
    
    def verify_availability(date, initial_time, final_time, room)
      raise Exceptions::NotComercialHour if (initial_time.present? || final_time.present?) && initial_time.strftime('%H:%M') < '09:00' && final_time.strftime('%H:%M') > '18:00'
      raise Exceptions::NonExistentRoom if room.present? && room.to_i <= 0 && room.to_i > MeetingManager::Creator::MAX_ROOM

      meetings = Meeting.where(room: room, date: date).where.not(id: id)
      initial = initial_time.strftime('%H:%M')
      final = final_time.strftime('%H:%M')
      found = meetings.any? { |m| m.initial_time.strftime('%H:%M').between?(initial, final) || m.final_time.strftime('%H:%M').between?(initial, final) }
      raise Exceptions::RoomNotAvailable if found
    end
  end
end