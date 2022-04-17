# frozen_string_literal: true
require 'rails_helper'

RSpec.describe MeetingManager::Shower do
  let!(:object) { create(:meeting) }
  let(:instance) { described_class.new(object.id) }
  let(:result) { instance.build }

  it { expect(result.class).to eq(Meeting) }
  it { expect(result.name).to eq(object.name) }
  it { expect(result.date).to eq(object.date) }
  it { expect(result.initial_time).to eq(object.initial_time) }
  it { expect(result.final_time).to eq(object.final_time) }

  context 'when id not exists' do
    let(:instance) { described_class.new(0) }

    it { expect {result}.to raise_error(ActiveRecord::RecordNotFound) }
  end

  context 'when id is nil' do
    let(:instance) { described_class.new(nil) }

    it { expect {result}.to raise_error(ActiveRecord::RecordNotFound) }
  end
end
