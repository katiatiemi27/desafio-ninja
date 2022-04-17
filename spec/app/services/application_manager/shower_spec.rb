# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ApplicationManager::Shower do
  let(:object) { create(:meeting) }
  let(:instance) { described_class.new(object.id) }

  it { expect { instance.build }.to raise_error(NotImplementedError) }  
end