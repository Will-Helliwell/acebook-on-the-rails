require 'bcrypt'

class User < ApplicationRecord
  include BCrypt
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze

  has_many :posts

  def password_string
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def login
    @user = User.find_by_email(params[:email])
    if @user.password == params[:password]
      give_token
    else
      redirect_to users_url
    end
  end

  validates :email,
    presence: true,
    length: { minimum: 10, maximum: 255 },
    format: { with: VALID_EMAIL_REGEX, message: "email address invalid, please try again" },
    uniqueness: { case_sensitive: false } #to avoid email duplication
  validates :password_string,
    presence: true,
    length: { minimum: 6, maximum: 255 }
end
