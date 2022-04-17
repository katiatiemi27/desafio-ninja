# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ErrorSerializer::RecordNotFound do
  let(:error) { Meeting.find(0) }
  let(:instance) { described_class.new(error) }
  let(:result) { JSON.parse(instance.to_json) }

  it { expect {error}.to raise_error("ActiveRecord::RecordNotFound: Couldn't find Meeting with 'id'=0") }
end
