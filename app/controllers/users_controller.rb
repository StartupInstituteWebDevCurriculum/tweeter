class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:follow, :unfollow]

  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets
  end

  def follow
    # unfollows vvv
    @user = User.find(params[:id])
    if current_user.following_users.include?(@user)
  
      current_user.following_users.destroy(@user)
      redirect_to tweets_path
    # follows vvv
    else 
      current_user.following_users << @user
      redirect_to show_user_url(@user)
    end
  end

end
