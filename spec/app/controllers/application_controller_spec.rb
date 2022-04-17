# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ApplicationController, type: :request do
  it { expect(described_class.superclass).to eq(ActionController::Base) }

  describe 'error handling' do
    # add more tests here after
  end
end