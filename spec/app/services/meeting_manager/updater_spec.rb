# frozen_string_literal: true
require 'rails_helper'

RSpec.describe MeetingManager::Updater, :redis do
  let(:meeting) { create(:meeting) }
  let(:params) {{ }}
  let(:instance) { described_class.new(meeting.id, params) }
  let(:result) { instance.update }
  let(:db_result) { Meeting.find(result.id) }

  context 'changing name' do
    let(:new_name) { 'NEW meeting name' }
    let(:params) { super().merge(name: new_name) }

    it { expect(result.class).to eq(Meeting) }
    it { expect(result.id).to eq(meeting.id) }
    it { expect(result.name).to eq(new_name) }
    it { expect(result.date).to eq(meeting.date) }
    it { expect(result.initial_time).to eq(meeting.initial_time) }
    it { expect(result.final_time).to eq(meeting.final_time) }
    it { expect(result.room).to eq(meeting.room) }
  end

  context 'changing date' do
    let(:date) { '2022-04-12' }
    let(:params) { super().merge(date: date) }

    it { expect(result.class).to eq(Meeting) }
    it { expect(result.id).to eq(meeting.id) }
    it { expect(result.name).to eq(meeting.name) }
    it { expect(result.date).to eq(date.to_date) }
    it { expect(result.initial_time).to eq(meeting.initial_time) }
    it { expect(result.final_time).to eq(meeting.final_time) }
    it { expect(result.room).to eq(meeting.room) }

    context 'when have another meeting in same room, date and hour' do
      let!(:meeting1) { create(:meeting, initial_time: '09:00', final_time: '09:30', date: '2022-04-12') }

      it { expect {result}.to raise_error(Exceptions::RoomNotAvailable), 'A sala escolhida não está disponível' }
    end
  end

  context 'changing initial_time' do
    let(:initial_time) { '09:30' }
    let(:params) { super().merge(initial_time: initial_time) }

    it { expect(result.class).to eq(Meeting) }
    it { expect(result.id).to eq(meeting.id) }
    it { expect(result.name).to eq(meeting.name) }
    it { expect(result.date).to eq(meeting.date) }
    it { expect(result.initial_time.strftime('%H:%M')).to eq(initial_time) }
    it { expect(result.final_time).to eq(meeting.final_time) }
    it { expect(result.room).to eq(meeting.room) }

    context 'when have another meeting in same room, date and hour' do
      let!(:meeting1) { create(:meeting, initial_time: '09:00') }

      it { expect {result}.to raise_error(Exceptions::RoomNotAvailable) }
    end

    context 'initial_time after final_time' do
      let(:initial_time) { '14:00' }

      it { expect {result}.to raise_error(Exceptions::InvalidHour) }
    end
  end

  context 'changing final_time' do
    let(:final_time) { '14:30' }
    let(:params) { super().merge(final_time: final_time) }

    it { expect(result.class).to eq(Meeting) }
    it { expect(result.id).to eq(meeting.id) }
    it { expect(result.name).to eq(meeting.name) }
    it { expect(result.date).to eq(meeting.date) }
    it { expect(result.final_time.strftime('%H:%M')).to eq(final_time) }
    it { expect(result.initial_time).to eq(meeting.initial_time) }
    it { expect(result.room).to eq(meeting.room) }

    context 'when have another meeting in same room, date and hour' do
      let!(:meeting1) { create(:meeting, final_time: '09:00') }

      it { expect {result}.to raise_error(Exceptions::RoomNotAvailable) }
    end

    context 'final_time before initial_time' do
      let(:final_time) { '09:00' }

      it { expect {result}.to raise_error(Exceptions::InvalidHour) }
    end
  end

  context 'changing room' do
    let(:room) { 3 }
    let(:params) { super().merge(room: room) }

    it { expect(result.class).to eq(Meeting) }
    it { expect(result.id).to eq(meeting.id) }
    it { expect(result.name).to eq(meeting.name) }
    it { expect(result.date).to eq(meeting.date) }
    it { expect(result.initial_time).to eq(meeting.initial_time) }
    it { expect(result.final_time).to eq(meeting.final_time) }
    it { expect(result.room).to eq(room) }

    context 'not existing room' do
      let(:room) { 10 }

      it { expect {result}.to raise_error(Exceptions::NonExistentRoom) }
    end
  end
end
