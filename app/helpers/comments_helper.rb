module CommentsHelper
  def comment_params
    params.require(:comment).permit(:body, :user_id, :post_id)
  end
end
