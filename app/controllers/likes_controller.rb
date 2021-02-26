class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post
  before_action :find_like, only: [:destroy]

  def create
    #@post = Post.find(params[:post_id])
    current_user.likes.create(post_id: params[:post_id])

    flash[:success] = "Post liked!"
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy
    
    flash[:info] = "Post no longer liked"
    redirect_back(fallback_location: root_path)
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_like
    @like = @post.likes.find(params[:id])
  end
end
