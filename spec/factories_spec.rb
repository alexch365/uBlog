# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'FactoryBot' do
  it 'successfully linted' do
    FactoryBot.lint traits: true, verbose: true
  end
end
