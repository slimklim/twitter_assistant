require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = User.new(provider: 'provider',
                      uid: 'uid',
                      name: 'name',
                      oauth_token: 'oauth_token',
                      oauth_secret: 'oauth_secret')
  end

  subject { @user }

  it { should respond_to(:provider) }
  it { should respond_to(:uid) }
  it { should respond_to(:name) }
  it { should respond_to(:oauth_token) }
  it { should respond_to(:oauth_secret) }
  it { should respond_to(:tweet) }
  it { should respond_to(:twitter_client) }

  it { should be_valid }

  describe "when provider is not present" do
    before { @user.provider = nil }
    it { should_not be_valid }
  end

  describe "when uid is not present" do
    before { @user.uid = nil }
    it { should_not be_valid }
  end

  describe "when name is not present" do
    before { @user.name = nil }
    it { should_not be_valid }
  end

  describe "when oauth_token is not present" do
    before { @user.oauth_token = nil }
    it { should_not be_valid }
  end

  describe "when oauth_secret is not present" do
    before { @user.oauth_secret = nil }
    it { should_not be_valid }
  end

end
