class TweetsController < ApplicationController

  before_action :signed_in_user
  before_action { @tweets = current_user.tweet.paginate(page: params[:page]) }
  around_action :temp_save_message, only: :create

  def new
  end

  def create
    tweet = make_tweet(twitter_params) if tweet_length_valid?
    if tweet
      internal_save(tweet)
      flash.now[:success] = 'Tweet pushed!'
      respond_some_format
    end
  rescue Twitter::Error => err
    flash.now[:danger] = err
    respond_some_format
  end

  private

    def twitter_params
      params.require(:tweet).permit(:message, :image)
    end

    def temp_save_message
      session[:message] = twitter_params[:message]
      yield
      session[:message] = ''
    end

    def tweet_length_valid?
      danger = danger_about_length(twitter_params[:message])
      if danger
        flash.now[:danger] = danger
        respond_some_format
        false
      else
        true
      end
    end

    def make_external_url(tweet)
      tweet_external_id = tweet[:id]
      username = tweet[:user][:screen_name]
      "https://twitter.com/#{username}/status/#{tweet_external_id}"
    end

    def internal_save(tweet)
      tweet = tweet.to_h
      url = make_external_url(tweet)
      image_url = tweet[:entities][:media][0][:media_url] if tweet[:entities][:media]
      current_user.tweet.create(message: twitter_params[:message],
                                url: url,
                                image_url: image_url)
    end

    def respond_some_format
      respond_to do |format|
        format.html {render :new}
        format.js
      end
    end

    def danger_about_length(message)
      if message.size > 140
        'Message is over 140 characters.'
      elsif message.size.zero?
        'Message is missing.'
      end
    end

    def make_tweet(params)
      if params[:image]
        current_user.twitter_client.update_with_media(params[:message],
                                                        params[:image].tempfile)
      else
        current_user.twitter_client.update(params[:message])
      end
    end

end
