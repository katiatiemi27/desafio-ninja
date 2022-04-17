module MeetingManager
  class Destroyer < ApplicationManager::Destroyer
    def execute_destruction
      meeting = Meeting.find_by!(id: id)
      meeting.destroy!
    end
  end
end