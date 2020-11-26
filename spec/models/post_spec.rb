require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:post) { user.posts.build(content: "Lorem ipsum", user_id: user.id) }

  context "when value is valid" do
    it "is valid" do
      expect(post).to be_valid
    end
  end
  
  context "when user_id is nil" do
    it "is invalid" do
      post.user_id = ""
      expect(post).not_to be_valid
    end
  end

  context "when user is destroyed" do
    it "post is destroyed" do
      post.save
      expect{ user.destroy }.to change{ Post.count }.by(-1)
    end
  end
end
