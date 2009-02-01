class LoginController < ApplicationController

  before_filter :authorize, :except => :login

  layout "post"
  def add_user
    @user = User.new(params[:user])
    if request.post? and @user.save
      flash.now[:notice] = "User #{@user.name} created"
      @user = User.new
    end
  end

  def edit_user
    @user = User.find_by_id(session[:user_id])
    if request.post?
        @user.update_attributes(params[:user])
        redirect_to :action => "list_users"
    end
     @user
end

def login
  session[:user_id] = nil
  if request.post?
    user = User.authenticate(params[:name], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to(:controller => "post", :action => "list")
    else
      flash[:notice] = "Invalid user/password combination"
    end
  end
end

def logout
  session[:user_id] = nil
  flash[:notice] = "ログアウトしました"
  redirect_to :action => "login"
end

def index

end

def delete_user
  if request.post?
    user = User.find(params[:id])
    begin
      user.destroy
      flash[:notice] = "ユーザ#{user.name}は削除されました"
    rescue Exception => e
      flash[:notice] = e.message
    end
  end
  redirect_to :action => :list_users
end

def list_users
  @all_users = User.find(:all)
end
end
