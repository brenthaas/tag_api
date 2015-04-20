require 'rails_helper'

describe Entity do
  it { is_expected.to validate_presence_of :type }
  it { is_expected.to validate_presence_of :identifier }
  it { is_expected.to validate_uniqueness_of :identifier }
end
