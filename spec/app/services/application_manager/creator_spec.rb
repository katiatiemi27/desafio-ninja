# frozen_string_literal: true
require 'rails_helper'

RSpec.shared_examples_for 'creation.rollback' do
  it { expect(Meeting.all).to be_empty }
end

RSpec.describe ApplicationManager::Creator do
  let(:params) { [] }
  let(:instance) { described_class.new }
  let(:result) { instance.create(*params) }

  it { expect{ result }.to raise_error(NotImplementedError) }
end
