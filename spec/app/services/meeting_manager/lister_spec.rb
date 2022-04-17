# frozen_string_literal: true
require 'rails_helper'

RSpec.describe MeetingManager::Lister, :redis do
  let!(:object) { create(:meeting) }
  let(:filters) {{ }}
  let(:instance) { described_class.new(filters) }
  let(:result) { instance.build }

  it { expect(result.first.class).to eq(Meeting) }
  it { expect(result.count).to eq(1) }
  it { expect(result.first.id).to eq(object.id) }

  context 'filtering by name' do
    let(:name) { object.name }
    let(:filters) { super().merge(name: name) }
    
    it { expect(result.count).to eq(1) }

    context 'when name not found in database' do
      let(:name) { 'test' }

      it { expect(result.count).to eq(0) }
    end
  end

  context 'filtering by date' do
    let(:date) { object.date }
    let(:filters) { super().merge(date: date) }

    it { expect(result.count).to eq(1) }

    context 'when date not found in database' do
      let(:date) { '2022-04-20' }

      it { expect(result.count).to eq(0) }
    end
  end

  context 'filtering by date' do
    let(:room) { object.room }
    let(:filters) { super().merge(room: room) }

    it { expect(result.count).to eq(1) }

    context 'when date not found in database' do
      let(:room) { 0 }

      it { expect(result.count).to eq(0) }
    end
  end
end
