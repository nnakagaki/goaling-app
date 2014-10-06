# == Schema Information
#
# Table name: goals
#
#  id          :integer          not null, primary key
#  title       :string(255)      not null
#  description :text
#  author_id   :integer          not null
#  completed   :boolean          default(FALSE), not null
#  public      :boolean          default(TRUE), not null
#  created_at  :datetime
#  updated_at  :datetime
#

class Goal < ActiveRecord::Base
  validates :title, :author, presence: true
  validates :completed, :public, inclusion: { in: [true, false] }

  belongs_to :author,
    class_name: "User",
    foreign_key: :author_id,
    inverse_of: :goals

  has_many :comments,
    as: :commentable,
    dependent: :destroy
end
