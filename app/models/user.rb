class User < ActiveRecord::Base
  has_one :candidate, dependent: :destroy
  accepts_nested_attributes_for :candidate

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  has_secure_password

  before_save :downcase_email

  attr_accessor :auth_token

  private

  def downcase_email
    self.email.downcase!
  end
end
