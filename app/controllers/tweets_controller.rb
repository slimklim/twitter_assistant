class TweetsController < ApplicationController

  before_action :signed_in_user
  around_action :temp_save_message, only: :create

  def new
  end

  def create
    if twitter_params[:image]
      current_user.tweetter_client.update_with_media(twitter_params[:message], twitter_params[:image].tempfile)
    else
      current_user.tweetter_client.update(twitter_params[:message])
    end
    flash[:success] = "Tweet pushed!"
    redirect_to root_path
  rescue Twitter::Error::Forbidden => err
    flash.now[:danger] = err.to_s.sub("Status", "Tweet")
    render :new
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
      session[:message] = ""
    end

end




