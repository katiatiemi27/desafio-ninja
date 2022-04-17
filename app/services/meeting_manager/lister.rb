module MeetingManager
  class Lister < ApplicationManager::Lister
    private

    def filter
      query = {
        name_eq: @filters[:name],
        date_eq: @filters[:date],
        room_eq: @filters[:room]
      }

      search = Meeting.ransack(query)
      search.result
    end
  end
end
