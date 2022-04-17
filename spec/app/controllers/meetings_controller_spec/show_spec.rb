# frozen_string_literal: true
require 'rails_helper'

RSpec.describe MeetingsController, type: :request  do
  describe 'show' do
    let!(:meeting) { create(:meeting) }
    let(:id) { meeting.id }
    let(:result) { JSON.parse(response.body) }
    before { get "/meetings/#{id}", params: {}, headers: {} }

    it 'success' do
      expect(response.code).to eq('200')
      expect(result.keys.sort).to eq(["created_at", "date", "final_time", "id", "initial_time", "name", "room", "updated_at"])
      expect(result['created_at']).to be_present
      expect(result['date']).to eq(meeting.date.to_s)
      expect(result['final_time'].to_time.strftime('%H:%M')).to eq(meeting.final_time.strftime('%H:%M'))
      expect(result['id']).to eq(meeting.id)
      expect(result['initial_time'].to_time.strftime('%H:%M')).to eq(meeting.initial_time.strftime('%H:%M'))
      expect(result['name']).to eq(meeting.name)
      expect(result['room']).to eq(meeting.room)
      expect(result['updated_at']).to be_present
    end

    context 'when id not exists' do
      let(:id) { 0 }

      it 'raise error' do
        expect(response.code).to eq('400')
        expect(result.keys.sort).to eq( ["message", "tag"])
        expect(result['message']).to eq('Registro não encontrado')
        expect(result['tag']).to eq('ActiveRecord::RecordNotFound')
      end
    end
  end
end
