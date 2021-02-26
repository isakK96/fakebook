class PostsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @friends = current_user.friends.all
    @posts = Post.where(user_id: current_user.friends).or(Post.where(user_id: current_user)).order(created_at: :desc)
    @comment = Comment.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    @comment = Comment.new(post_id: params[:post_id])
  end

  def create
    @post = current_user.posts.build(posts_params)
    if @post.save
      flash.notice = "Post created!"
      redirect_back(fallback_location: root_path)
    end
    #redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    #flash.notice = "post '#{@post.title}' Deleted!"
    #redirect_to posts_path
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)

    #flash.notice = "post '#{@post.title}' Updated!"
    #redirect_to post_path(@post)
  end

  private

  def posts_params
    params.permit(:body)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
