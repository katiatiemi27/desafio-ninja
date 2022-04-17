require 'rails_helper'

RSpec.describe MeetingsController, type: :request  do
  describe 'destroy' do
    let!(:meeting) { create(:meeting) }
    let(:result) { JSON.parse(response.body) }
    let(:db_result) { Meeting.find(meeting.id) }
    let(:id) { meeting.id }
    before { delete "/meetings/#{id}", headers: {} }

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

      expect {db_result}.to raise_error(ActiveRecord::RecordNotFound)
    end

    context 'when id nonexistent' do
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
