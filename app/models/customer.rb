class Customer < ActiveRecord::Base
  include Constants

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  has_many :emails, as: :emailable
  has_many :phones, as: :phoneable
  has_many :orders
  # has_one :primary_email, -> {where primary: true}, as: :emailable, inverse_of: :emailable, class_name: 'Email'

  accepts_nested_attributes_for :emails, allow_destroy: true
  accepts_nested_attributes_for :phones, allow_destroy: true

  before_save :check_completed

  validates_format_of :first_name, with: ALPHA_REGEX, allow_blank: true
  validates_format_of :last_name, with: ALPHA_REGEX, allow_blank: true
  validates_numericality_of :total_ordered, :discount, allow_blank: true

  def mandatory
    [
        :email,
        :first_name,
        :last_name
    ]
  end

  def mandatory_completed?
    mandatory.all? do |field|
      self.send(field).present? && !self.send(field).blank?
    end
  end

  def check_completed
    if mandatory_completed?
      self.completed = true unless self.completed?
    else
      self.completed = false
    end

    true
  end
end
