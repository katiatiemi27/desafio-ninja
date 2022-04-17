class Meeting < ApplicationRecord
  MAX_ROOM = 4.freeze

  validates_presence_of :room, :name, :date
  validates :initial_time, presence: true, allow_nil: false
  validates :final_time, presence: true, allow_nil: false
  # validates :room, :inclusion => 1..MAX_ROOM
  # validate :verification_same_day
  # validate :comercial_hour

  # def verification_same_day
  #   binding.remote_pry
  #   return if (initial_time.day == final_time.day) && (initial_time.month == final_time.month) && 
  #             (initial_time.year == final_time.year) && (initial_time < final_time)
  #   errors.add(:date, I18n.t('activerecord.exceptions.invalid_date'))
  # end

  # def comercial_hour
  #   return if initial_time.between?(DateTime.new(.initial_time.year, initial_time.month, initial_time.day, 9, 00), DateTime.new(initial_time.year, initial_time.month, initial_time.day, 18, 00)) &&
  #             final_time.between?(DateTime.new(final_time.year, final_time.month, final_time.day, 9, 00), DateTime.new(final_time.year, final_time.month, final_time.day, 18, 00))
  #   errors.add(:hour, I18n.t('activerecord.exceptions.not_comercial_hour'))
  # end
end