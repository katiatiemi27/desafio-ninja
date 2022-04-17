# frozen_string_literal: true
require 'rails_helper'

RSpec.describe MeetingsController, type: :request  do
  describe 'index' do
    let!(:meeting) { create(:meeting) }
    let!(:meeting2) { create(:meeting, room: 2, date: '2022-04-12', name: 'test1') }
    let!(:meetin3) { create(:meeting, room: 3, date: '2022-04-13', name: 'test2') }
    let(:params) {{  }}
    let(:result) { JSON.parse(response.body) }
    before { get '/meetings', params: params, headers: headers }

    it 'success' do
      expect(response.code).to eq('200')
      expect(result.count).to eq(3)
      expect(result.first.class).to eq(Hash)
    end

    context 'filtering by name' do
      let(:name) { meeting.name }
      let(:params) { super().merge({ name: name }) }

      it 'success' do
        expect(response.code).to eq('200')
        expect(result.count).to eq(1)
        expect(result.first.class).to eq(Hash)
      end

      context 'when name not in database' do
        let(:name) { 'testtt' }

        it { expect(result.count).to eq(0) }
      end

      context 'when name equal nil' do
        let(:name) { nil }

        it { expect(result.count).to eq(3) }
      end

      context 'when name equal empty' do
        let(:name) { '' }

        it { expect(result.count).to eq(3) }
      end
    end

    context 'filtering by name' do
      let(:date) { meeting.date }
      let(:params) { super().merge({ date: date }) }

      it 'success' do
        expect(response.code).to eq('200')
        expect(result.count).to eq(1)
        expect(result.first.class).to eq(Hash)
      end

      context 'when name not in database' do
        let(:date) { '2023-01-01' }

        it { expect(result.count).to eq(0) }
      end

      context 'when name equal nil' do
        let(:date) { nil }

        it { expect(result.count).to eq(3) }
      end

      context 'when name equal empty' do
        let(:date) { '' }

        it { expect(result.count).to eq(3) }
      end
    end

    context 'filtering by name' do
      let(:room) { meeting.room }
      let(:params) { super().merge({ room: room }) }

      it 'success' do
        expect(response.code).to eq('200')
        expect(result.count).to eq(1)
        expect(result.first.class).to eq(Hash)
      end

      context 'when name not in database' do
        let(:room) { 0 }

        it { expect(result.count).to eq(0) }
      end

      context 'when name equal nil' do
        let(:room) { nil }

        it { expect(result.count).to eq(3) }
      end

      context 'when name equal empty' do
        let(:room) { '' }

        it { expect(result.count).to eq(3) }
      end
    end
  end
end