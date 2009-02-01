class PostController < ApplicationController

  before_filter :authorize

  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @post_pages, @posts = paginate :posts, :order => 'created DESC', :per_page => 10
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])
    @post.created = Time.now
    user = User.find_by_id(session[:user_id])
    @post.user = user.name
    if @post.save
      flash[:notice] = 'Post was successfully created.'
      flash[:postmsg] = 'つぶやきに成功しました'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      flash[:notice] = 'Post was successfully updated.'
      redirect_to :action => 'show', :id => @post
    else
      render :action => 'edit'
    end
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
