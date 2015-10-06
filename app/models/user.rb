class User < ActiveRecord::Base
  before_validation :sanitize_email

  has_secure_password

  validates :name, presence: true, length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                      length: { maximum: 100 },
                      format: VALID_EMAIL_REGEX,
                  uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }

  def sanitize_email
    self.email = email.downcase
  end
end
