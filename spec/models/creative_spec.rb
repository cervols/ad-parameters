require 'rails_helper'

RSpec.describe Creative, type: :model do
  it "validates presence of identifier" do
    creative = Creative.new

    expect(creative).not_to be_valid
    expect(creative.errors.messages[:identifier]).to include("can't be blank")
  end
end
