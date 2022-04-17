class Meeting < ApplicationRecord
  MAX_ROOM = 4.freeze

  validates_presence_of :room, :name, :date
  validates :initial_time, presence: true, allow_nil: false
  validates :final_time, presence: true, allow_nil: false
end