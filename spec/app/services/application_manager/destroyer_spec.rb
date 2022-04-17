# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ApplicationManager::Destroyer do
  let(:object) { create(:meeting) }
  let(:instance) { described_class.new(object.id) }
  let(:result) { instance.destroy }

  it { expect{ result }.to raise_error(NotImplementedError) }
end