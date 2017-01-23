class TweetsController < ApplicationController

  before_action :signed_in_user
  around_action :temp_save_message, only: :create
  before_action :check_tweet_length, only: :create

  def new
    @tweets = current_user.tweet.paginate(page: params[:page])
  end

  def create
    tweet = twitter_params[:image] ?
      current_user.tweetter_client.update_with_media(twitter_params[:message],
                                                      twitter_params[:image].tempfile) :
      current_user.tweetter_client.update(twitter_params[:message])
    internal_save(tweet)
    flash[:success] = 'Tweet pushed!'
    redirect_to root_path
  rescue Twitter::Error => err
    flash.now[:danger] = err
    render :new
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

    def check_tweet_length
      if twitter_params[:message].size > 140
        flash.now[:danger] = 'Message is over 140 characters.'
        render :new
      elsif twitter_params[:message].size.zero?
        flash.now[:danger] = 'Message is missing.'
        render :new
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

end
