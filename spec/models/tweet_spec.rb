require 'rails_helper'

RSpec.describe Tweet, type: :model do

  let(:user) { FactoryGirl.create(:user) }

  before do
    @tweet = user.tweet.new(url: 'url',
                             message: 'foobar')
  end

  subject { @tweet }

  it { should respond_to(:user) }
  it { should respond_to(:user_id) }
  it { should respond_to(:url) }
  it { should respond_to(:message) }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @tweet.user_id = nil }
    it { should_not be_valid }
  end

  describe "when url is not present" do
    before { @tweet.url = nil }
    it { should_not be_valid }
  end

  describe "when message is not present" do
    before { @tweet.message = nil }
    it { should_not be_valid }
  end

  describe "when message is too long" do
    before { @tweet.message = 'q' * 141 }
    it { should_not be_valid }
  end

end
