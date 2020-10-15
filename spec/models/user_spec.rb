require 'rails_helper'

RSpec.describe User, type: :model do
  let(:name) { "test_user" }
  let(:email) { "test@test.test" }
  let(:password) { "password" }

  context "when value is appropriate" do
    it "can create" do
      test_user = User.create(
        name: name,
        email: email,
        password: password,
        password_confirmation: password
        )
      expect(test_user).to be_valid
    end
  end

  context "when name is blank" do
    let(:name) { "" }

    it "can not create" do
      test_user = User.create(
        name: name,
        email: email,
        password: password,
        password_confirmation: password
        )
      expect(test_user).not_to be_valid
    end
  end

  context "when email is blank" do
    let(:email) { "" }

    it "can not create" do
      test_user = User.create(
        name: name,
        email: email,
        password: password,
        password_confirmation: password
        )
      expect(test_user).not_to be_valid
    end
  end

  context "when email is duplicate" do
    let(:upcase_email) { "TEST@TEST.TEST" }

    it "can not create" do
      test_user = User.create(
        name: name,
        email: email,
        password: password,
        password_confirmation: password
        )
      other_user = User.new(
        name: name,
        email: upcase_email,
        password: password,
        password_confirmation: password
        )
      expect(other_user).not_to be_valid
    end
  end

  context "when password is blank" do
    let(:password) { "" }

    it "can not create" do
      test_user = User.create(
        name: name,
        email: email,
        password: password,
        password_confirmation: password
        )
      expect(test_user).not_to be_valid
    end
  end
end
