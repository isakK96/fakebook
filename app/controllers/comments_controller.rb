class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: :destroy

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(comment_params)
    @comment.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.Comment.find(params[:id])
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :user_id, :post_id)
  end

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end
end
