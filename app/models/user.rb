class User < ApplicationRecord
  before_save :downcase_email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name,
    presence: true,
    length: {maximum: Settings.maximum_name_length}

  validates :email,
    presence: true,
    length: {maximum: Settings.maximum_email_length},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}

  has_secure_password
  validates :password,
    presence: true,
    length: {minimum: Settings.minimum_password_length}

  private
  def downcase_email
    self.email = email.downcase
  end
end
