class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    current_user.likes.create(post_id: params[:post_id])

    flash[:success] = "Post liked!"
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy
    flash[:info] = "Post no longer liked"
  end
end
