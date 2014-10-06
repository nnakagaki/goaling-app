class GoalsController < ApplicationController
  def show
    @goal = Goal.find(params[:id])
    render :show
  end

  def create
    @goal = current_user.goals.new(goal_params)
    if @goal.save
      flash[:notice] = ["Goal added!"]
      redirect_to user_goal_url(current_user,@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render 'users/show' [user: @goal.author]
    end
  end

  def edit
    @goal = Goal.find(params[:id])
    render :edit
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
      flash[:notice] = "Goal updated!"
      redirect_to user_goal_url(current_user,@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to user_url(@goal.author)
  end

  private
  def goal_params
    params.require(:goal).permit(:title, :description, :public)
  end
end
