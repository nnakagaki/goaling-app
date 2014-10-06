# == Schema Information
#
# Table name: goal_comments
#
#  id         :integer          not null, primary key
#  body       :text             not null
#  author_id  :integer          not null
#  goal_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class GoalComment < ActiveRecord::Base
  validates :body, :author, :goal, presence: true

  belongs_to :author,
    class_name: "User",
    foreign_key: :author_id,
    inverse_of: :authored_goal_comments

  belongs_to :goal,
    class_name: "Goal",
    foreign_key: :goal_id,
    inverse_of: :comments

end
