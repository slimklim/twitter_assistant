class User < ApplicationRecord

  has_many :tweet

  validates :provider, :uid, :name, :oauth_token, :oauth_secret, presence: true

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.name = auth['info']['nickname']
      user.oauth_token = auth.credentials.token
      user.oauth_secret = auth.credentials.secret
    end
  end

  def twitter_client
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.config.twitter_key
      config.consumer_secret     = Rails.application.config.twitter_secret
      config.access_token        = oauth_token
      config.access_token_secret = oauth_secret
    end
    client
  end

end
