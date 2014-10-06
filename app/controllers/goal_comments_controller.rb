class GoalCommentsController < ApplicationController

  def create
    @goal_comment = current_user.authored_goal_comments.new(goal_comment_params)
    if @goal_comment.save
      flash[:notice] = ["Comment added!"]
    else
      flash[:errors] = @goal_comment.errors.full_messages
    end
    redirect_to user_goal_url(@goal_comment.goal.author_id, params[:goal_id])
  end

  private
  def goal_comment_params
    params.require(:goal_comment).permit(:body).merge(goal_id: params[:goal_id])
  end
end
