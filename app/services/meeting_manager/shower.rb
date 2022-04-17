module MeetingManager
  class Shower < ApplicationManager::Shower
    private

    def instance
      Meeting.find(id)
    end
  end
end
