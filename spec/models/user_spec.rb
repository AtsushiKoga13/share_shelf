require 'rails_helper'

RSpec.describe User, type: :model do
  let(:name) { "test_user" }
  let(:email) { "test@test.test" }
  let(:password) { "password" }

  subject { test_user = User.create(
            name: name,
            email: email,
            password: password,
            password_confirmation: password
            ) }

  context "when value is appropriate" do
    it { is_expected.to be_valid }
  end

  context "when name is blank" do
    let(:name) { "" }

    it { is_expected.not_to be_valid }
  end

  context "when name is too long" do
    let(:name) { "a" * 51 }

    it { is_expected.not_to be_valid }
  end

  context "when email is blank" do
    let(:email) { "" }

    it { is_expected.not_to be_valid }
  end

  context "when email is too long" do
    let(:email) { "a" * 255 + "@a.a" }

    it { is_expected.not_to be_valid }
  end

  context "when email format is invalid" do
    let(:email) { "テスト@テスト.テスト" }

    it { is_expected.not_to be_valid }
  end

  context "when email is duplicate" do
    let(:email) { "TEST@TEST.TEST" }

    it "can not create" do
      other_user = User.create(
        name: name,
        email: "test@test.test",
        password: password,
        password_confirmation: password
        )
      is_expected.not_to be_valid
    end
  end

  context "when password is blank" do
    let(:password) { "" }

    it { is_expected.not_to be_valid }
  end

  context "when password is too short" do
    let(:password) { "pass" }

    it { is_expected.not_to be_valid }
  end
end
