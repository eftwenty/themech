class User < ActiveRecord::Base
  ROLES = %w(Admin Calls Finance HR)

  devise :database_authenticatable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  has_many  :emails, as: :emailable, dependent: :destroy

  accepts_nested_attributes_for :emails, allow_destroy: true
  acts_as_taggable_on :roles

  validates_format_of :email, with: Email::EMAIL_REGEX
  validates_uniqueness_of :email

  after_create :created_notification

  def admin?
    role_list.include?('Admin')
  end

  def created_notification
    UserMailer.send_created_user_notification(self).deliver
  end
end
