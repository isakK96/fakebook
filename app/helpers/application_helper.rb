module ApplicationHelper
  def invalid_friend?(user)
    current_user.id == params[:user_id] ||
      current_user.friend_sent.exists?(receiver_id: user.id, status: false) ||
      current_user.friend_request.exists?(sender_id: user.id, status: false)
  end
end
