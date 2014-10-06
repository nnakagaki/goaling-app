# == Schema Information
#
# Table name: user_comments
#
#  id         :integer          not null, primary key
#  body       :text             not null
#  author_id  :integer          not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class UserComment < ActiveRecord::Base
  validates :body, :user, :author, presence: true

  belongs_to :author,
    class_name: "User",
    foreign_key: :author_id,
    inverse_of: :authored_user_comments

  belongs_to :user,
    class_name: "User",
    foreign_key: :user_id,
    inverse_of: :comments
end
