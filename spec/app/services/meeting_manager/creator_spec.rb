# frozen_string_literal: true
require 'rails_helper'

RSpec.describe MeetingManager::Creator, :redis do
  let!(:meeting1) { nil }
  let(:meeting) { build(:meeting) }
  let(:instance) { described_class.new(meeting.room, meeting.date, meeting.initial_time, meeting.final_time, meeting.name) }
  let(:result) { instance.create }
  let(:db_result) { Meeting.find(result.id) }

  it 'meeting created' do
    result
    expect(Meeting.count).to eq(1)
    expect(db_result.room).to eq(meeting.room)
    expect(db_result.date).to eq(meeting.date)
    expect(db_result.initial_time).to eq(meeting.initial_time)
    expect(db_result.final_time).to eq(meeting.final_time)
    expect(db_result.name).to eq(meeting.name)
  end

  describe 'when another meeting scheduled for same data and same room - not same hour' do
    let!(:meeting1) { create(:meeting, initial_time: '11:15', final_time: '12:00', name: 'Reunião Marketing') }

    it 'meeting created' do
      result
      expect(Meeting.count).to eq(2)
      expect(db_result.room).to eq(meeting.room)
      expect(db_result.date).to eq(meeting.date)
      expect(db_result.initial_time).to eq(meeting.initial_time)
      expect(db_result.final_time).to eq(meeting.final_time)
      expect(db_result.name).to eq(meeting.name)
    end

    describe 'same hour' do
      let!(:meeting1) { create(:meeting, initial_time: '11:00', final_time: '13:00', name: 'Reunião Produtos') }

      it 'meeting not created - raise exception' do
        expect { result }.to raise_error(Exceptions::RoomNotAvailable)
        expect(Meeting.count).to eq(1)
      end
    end
  end

  describe 'not comercial hour' do
    let!(:meeting) { create(:meeting, initial_time: '08:00') }

    it { expect { result }.to raise_error(Exceptions::NotComercialHour) }

    context 'initial_time after 18:00' do
      let!(:meeting) { create(:meeting, initial_time: '20:00', final_time: '22:00') }

      it { expect { result }.to raise_error(Exceptions::NotComercialHour) }
    end

    context 'final_time before 09:00' do
      let!(:meeting) { create(:meeting, initial_time: '06:00', final_time: '07:00') }

      it { expect { result }.to raise_error(Exceptions::NotComercialHour) }
    end

    context 'final_time after 18:00' do
      let!(:meeting) { create(:meeting, final_time: '22:00') }

      it { expect { result }.to raise_error(Exceptions::NotComercialHour) }
    end
  end

  describe 'room not existent' do
    let!(:meeting) { create(:meeting, room: 0) }

    it { expect { result }.to raise_error(Exceptions::NonExistentRoom) }

    context 'room bigger than 4' do
      let!(:meeting) { create(:meeting, room: 10) }

      it { expect { result }.to raise_error(Exceptions::NonExistentRoom) }
    end
  end

  describe 'when initial_time is after final_time' do
    let!(:meeting) { create(:meeting, initial_time: '16:00') }

    it { expect { result }.to raise_error(Exceptions::InvalidHour) }
  end
end
