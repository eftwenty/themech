class User < ActiveRecord::Base
  ALPHA_REGEX = /\A^[A-z]+$\z/
  ROLES = %w(Admin Calls Finance HR)

  has_many  :emails, as: :emailable, dependent: :destroy
  has_one   :primary_email, -> {where primary: true}, as: :emailable, inverse_of: :emailable, class_name: 'Email'

  accepts_nested_attributes_for :emails, allow_destroy: true
  acts_as_taggable_on :roles

  validates_presence_of :first_name, :last_name
  validates_format_of :first_name, :last_name, with: ALPHA_REGEX

  after_save :created_notification

  def pretty_roles
    roles.map(&:name).join(', ')
  end
  # validates_associated :primary_email
  # validates_length_of :primary_email, {maximum: 1}

    # validates_uniqueness_of :primary_email

  # validates :primary_email, length: { maximum: 1 }

  def created_notification
    UserMailer.send_created_user_notification(self).deliver
  end
end
