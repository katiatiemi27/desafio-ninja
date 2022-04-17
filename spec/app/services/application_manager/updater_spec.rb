# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ApplicationManager::Updater do
  let(:old_name) { 'old name' }
  let(:name) { 'New meeting name' }
  let(:object) { create(:meeting, name: old_name) }
  let(:instance) { described_class.new(object.id) }
  let(:result) { instance.update }

  it { expect { result }.to raise_error(NotImplementedError) }
end