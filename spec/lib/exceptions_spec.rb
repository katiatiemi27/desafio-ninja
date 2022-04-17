# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Exceptions do
  let(:instance) { described_class::Base.new }

  it { expect(instance.code).to eq(500) }
  it { expect(instance.message).to eq('serviço indisponível') }
end