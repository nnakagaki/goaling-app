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

require 'rails_helper'

RSpec.describe UserComment, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
