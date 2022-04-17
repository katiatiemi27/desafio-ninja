# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ApplicationManager::Lister do
  let(:filters) {{ }}
  let(:instance) { described_class.new(filters) }
  let(:result) { instance.build }

  it { expect { result }.to raise_error(NotImplementedError) }

  context 'with filters' do
    before { allow(instance).to receive(:filter).and_return(Meeting.all) }

    it 'checking result' do
      expect(result).to be_empty
    end

    context 'when 1 element' do
      let!(:meeting) { create(:meeting) }
      before { result }

      it 'checking result' do
        expect(result.count).to eq(1)
      end
    end

    context 'with 3 elements' do
      let!(:meetings) { create_list(:meeting, 3) }
      before { result }

      it 'checking result' do
        expect(result.count).to eq(3)
      end
    end
  end
end