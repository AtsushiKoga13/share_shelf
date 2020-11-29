require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:user) { create(:user) }
  let(:other_user) { create(:other_user) }

  it "active relationship is valid" do
    relationship = user.active_relationships.build(followed_id: other_user.id)
    expect(relationship).to be_valid
  end

  it "passive relationship is valid" do
    relationship = user.passive_relationships.build(follower_id: other_user.id)
    expect(relationship).to be_valid
  end

  it "requires a followed_id" do
    relationship = user.active_relationships.build(followed_id: nil)
    expect(relationship).not_to be_valid
  end

  it "requires a follower_id" do
    relationship = user.passive_relationships.build(follower_id: nil)
    expect(relationship).not_to be_valid
  end

  context "when user is destroyed" do
    it "active_relationship is destroyed" do
      user.active_relationships.create(followed_id: other_user.id)
      expect(Relationship.count).to eq 1
      expect { user.destroy }.to change(Relationship, :count).from(1).to(0)
    end

    it "passive_relationship is destroyed" do
      user.passive_relationships.create(follower_id: other_user.id)
      expect(Relationship.count).to eq 1
      expect { user.destroy }.to change(Relationship, :count).from(1).to(0)
    end
  end
end
