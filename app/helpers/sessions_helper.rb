module SessionsHelper

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def signed_in?
    !current_user.nil?
  end

  def signed_in_user
    unless signed_in?
      flash[:danger] = "Please sign in."
      redirect_to welcome_path
    end
  end


end
