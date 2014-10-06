# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  validates :username, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :preset_session_token

  has_many :goals,
    class_name: "Goal",
    foreign_key: :author_id,
    inverse_of: :author

  has_many :authored_user_comments,
    class_name: "UserComment",
    foreign_key: :author_id,
    inverse_of: :author

  has_many :authored_goal_comments,
    class_name: "GoalComment",
    foreign_key: :author_id,
    inverse_of: :author

  has_many :comments,
    class_name: "UserComment",
    foreign_key: :user_id,
    inverse_of: :user

  attr_reader :password

  def self.find_by_credentials(user_params)
    user = User.find_by_username(user_params[:username])
    user && user.is_password?(user_params[:password]) ? user : nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64(16)
    self.save
    self.session_token
  end

  private
  def preset_session_token
    self.session_token = SecureRandom::urlsafe_base64(16)
  end


end
