require 'rails_helper'

RSpec.describe Placement, type: :model do
  it "validates presence of identifier" do
    placement = Placement.new

    expect(placement).not_to be_valid
    expect(placement.errors.messages[:identifier]).to include("can't be blank")
  end
end
