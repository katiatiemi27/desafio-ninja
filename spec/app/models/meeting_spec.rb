# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Meeting, type: :model do

  context 'validations' do
    subject{ build(:meeting) }
    it { should validate_presence_of(:room) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:date) }
  end
  
  describe 'checking some rules' do
    let(:object) { create(:meeting) }
    let(:result) { Meeting.find(object.id) }

    it { expect(result.class).to be_present }
    it { expect(result.final_time).to be_present }
    it { expect(result.initial_time).to be_present }
  end
end
