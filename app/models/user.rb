class User < ActiveRecord::Base
  ROLES = %w(Worker Calls Finance HR Admin)
  ROLES_WITHOUT_ADMIN = %w(Worker Calls Finance HR)

  devise :database_authenticatable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  has_many  :emails, as: :emailable, dependent: :destroy
  has_many  :phones, as: :phoneable, dependent: :destroy
  has_and_belongs_to_many :orders

  accepts_nested_attributes_for :emails, allow_destroy: true
  accepts_nested_attributes_for :phones, allow_destroy: true
  acts_as_taggable_on :roles, :work_variety

  ### Validations

  validates_format_of :email, with: Email::EMAIL_REGEX
  validates_uniqueness_of :email
  validates_presence_of :work_variety_list, if: -> obj { obj.role_list.include? 'Worker' }
  validate :admin_presence

  def admin_presence
    errors.add(:role_list, :uniq) if role_list.include?('Admin') && User.tagged_with('Admin').present?
  end

  after_create :created_notification

  before_create do
    if self.role_list.include?('Worker')
      self.status = 'Free'
    end
  end

  ### Helper methods

  def admin?
    role_list.include?('Admin')
  end

  def self.role_exists? *roles
    tagged_with(roles).present?
  end

  ### Callbacks

  def created_notification
    UserMailer.send_created_user_notification(self).deliver
  end
end
