# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ErrorSerializer::Base do
  let(:instance) { described_class.new(StandardError.new()) }
  let(:result) { instance.to_json }

  it { expect(result['message']).to eq('message') }
end
