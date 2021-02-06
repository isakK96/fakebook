class FriendshipsController < ApplicationController
  include ApplicationHelper

  def create
    @user = User.find(params[:user_id])

    # make sure users cant send requests to themselves, or twice to the same user.
    if invalid_friend?(@user)
      flash[:warning] = "You can't add yourself!"
      redirect_back fallback_location: root_url
    else
      @friendship = current_user.friend_sent.build(receiver_id: params[:user_id])
      if @friendship.save
        flash[:success] = "Request sent"
      else
        flash[:warning] = "Request failed"
      end
      redirect_back fallback_location: root_url
    end
  end

  # accepting a friend request and establishing a mutual friendship
  def update
    @friendship = Friendship.find_by(sender_id: params[:user_id], receiver_id: current_user.id, status: false)
    return unless @friendship

    @friendship.status = true
    if @friendship.save
      flash[:success] = "Request accepted"
      @friendship_mutual = current_user.friend_sent.build(receiver_id: params[:user_id], status: true)
      @friendship_mutual.save
    else
      flash[:warning] = "Request failed"
    end

    redirect_back fallback_location: root_url
  end

  def destroy
    @friendship = Friendship.find_by(sender_id: params[:user_id], receiver_id: current_user.id, status: false)
    return unless @friendship

    @friendship.destroy
    flash[:success] = "Request declined"
    redirect_back fallback_location: root_url
  end
end
