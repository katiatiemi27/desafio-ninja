# frozen_string_literal: true
require 'rails_helper'

RSpec.describe MeetingManager::Destroyer, :redis do
  let(:meeting) { create(:meeting) }
  let(:instance) { described_class.new(meeting.id) }
  let(:result) { instance.destroy }

  it { expect(result.class).to eq(Meeting) }
  it { expect(result.id).to eq(meeting.id) }

  context 'when id not exits' do
    let(:instance) { described_class.new(0) }

    it { expect {result}.to raise_error(ActiveRecord::RecordNotFound) }
  end

  context 'when id is nil' do
    let(:instance) { described_class.new(nil) }

    it { expect {result}.to raise_error(ActiveRecord::RecordNotFound) }
  end
end
