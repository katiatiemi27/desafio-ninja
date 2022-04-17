# frozen_string_literal: true
require 'rails_helper'

RSpec.describe MeetingsController, type: :request  do
  describe 'create' do
    let!(:meeting) { build(:meeting) }
    let(:params) {{ room: meeting.room, date: meeting.date, initial_time: '09:00', final_time: '10:00', name: meeting.name }}
    let(:result) { JSON.parse(response.body) }
    before { post "/meetings", params: params, headers: {} }

    it 'success' do
      expect(response.code).to eq('200')
      expect(result.keys.sort).to eq(["created_at", "date", "final_time", "id", "initial_time", "name", "room", "updated_at"])
      expect(result['created_at']).to be_present
      expect(result['date']).to eq('2022-04-11')
      expect(result['final_time'].to_time.strftime('%H:%M')).to eq('10:00')
      expect(result['id']).to be_present
      expect(result['initial_time'].to_time.strftime('%H:%M')).to eq('09:00')
      expect(result['name']).to eq(meeting.name)
      expect(result['room']).to eq(meeting.room)
      expect(result['updated_at']).to be_present
    end
  end
end
