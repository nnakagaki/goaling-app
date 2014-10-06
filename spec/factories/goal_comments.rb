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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :goal_comment do
  end
end
