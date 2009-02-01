# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_weblog_session_id'

  private

  def authorize
    unless User.find_by_id(session[:user_id])
      flash[:notice] = "ログインしてください"
      redirect_to(:controller => "login", :action => "login")
    end
  end
end
