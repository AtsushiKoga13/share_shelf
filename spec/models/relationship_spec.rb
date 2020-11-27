require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:user) { create(:user, :a) }
  let(:other_user) { create(:user, :b) }
  let(:relationship) { Relationship.new(follower_id: user.id, followed_id: other_user.id) }

  it "should be valid" do
    expect(relationship).to be_valid
  end

  it "should require a follower_id" do
    relationship.follower_id = nil
    expect(relationship).not_to be_valid
  end

  it "should require a followed_id" do
    relationship.followed_id = nil
    expect(relationship).not_to be_valid
  end
end
