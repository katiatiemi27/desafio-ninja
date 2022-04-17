require 'rails_helper'

RSpec.describe MeetingsController, type: :request  do
  let!(:object) { create(:meeting) }
  let(:new_name) { 'NEw name' }
  let(:params) {{ name: new_name }}
  let(:result) { JSON.parse(response.body) }
  let(:id) { object.id }
  before { put "/meetings/#{id}", params: params, headers: {} }

  it 'success' do
    expect(response.code).to eq('200')
    expect(result.keys.sort).to eq(["created_at", "date", "final_time", "id", "initial_time", "name", "room", "updated_at"])
    expect(result['created_at']).to be_present
    expect(result['date']).to eq(object.date.to_s)
    expect(result['final_time'].to_time.strftime('%H:%M')).to eq(object.final_time.strftime('%H:%M'))
    expect(result['id']).to eq(object.id)
    expect(result['initial_time'].to_time.strftime('%H:%M')).to eq(object.initial_time.strftime('%H:%M'))
    expect(result['name']).to eq(new_name)
    expect(result['room']).to eq(object.room)
    expect(result['updated_at']).to be_present
  end

  context 'when id equal 0' do
    let(:id) { 0 }

    it 'success' do
      expect(response.code).to eq('400')
      expect(result.keys.sort).to eq(["message", "tag"])
      expect(result['tag']).to eq('ActiveRecord::RecordNotFound')
      expect(result['message']).to eq('Registro não encontrado')
    end
  end
end