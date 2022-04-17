module MeetingManager
  class Creator < ApplicationManager::Creator
    MAX_ROOM = 4
    attr_reader :room, :initial_time, :final_time, :name, :date
    
    private

    def execute_creation
      raise Exceptions::InvalidHour if initial_time > final_time
      raise Exceptions::NotComercialHour unless initial_time.strftime('%H:%M').between?('09:00', '18:00') &&
                                                final_time.strftime('%H:%M').between?('09:00', '18:00')
      raise Exceptions::NonExistentRoom if room.to_i <= 0 || room.to_i > MAX_ROOM

      verify_availability
      Meeting.create!(room: room, date: date, initial_time: initial_time, final_time: final_time, name: name)
    end

    def verify_availability
      meetings = Meeting.where(room: room, date: date)
      initial = initial_time.strftime('%H:%M')
      final = final_time.strftime('%H:%M')
      found = meetings.any? { |m| m.initial_time.strftime('%H:%M').between?(initial, final) || m.final_time.strftime('%H:%M').between?(initial, final) }
      raise Exceptions::RoomNotAvailable if found
    end

    def initialize(room, date, initial_time, final_time, name)
      @room = room
      @date = date
      @initial_time = initial_time
      @final_time = final_time
      @name = name
    end
  end
end