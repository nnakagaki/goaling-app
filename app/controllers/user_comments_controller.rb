class UserCommentsController < ApplicationController

  def create
    @user_comment = current_user.authored_user_comments.new(user_comment_params)
    if @user_comment.save
      flash[:notice] = ["Comment added!"]
      redirect_to user_url(@user_comment.user_id)
    else
      flash.now[:errors] = @user_comment.errors.full_messages
      render 'users/show' [user: @user_comment.user]
    end
  end

  private
  def user_comment_params
    params.require(:user_comment).permit(:body).merge(user_id: params[:user_id])
  end
end
