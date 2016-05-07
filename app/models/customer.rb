class Customer < ActiveRecord::Base
  ALPHA_REGEX = /\A^[A-z]+$\z/

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  has_many :emails, as: :emailable
  # has_one :primary_email, -> {where primary: true}, as: :emailable, inverse_of: :emailable, class_name: 'Email'

  # validates_presence_of :first_name, :last_name
  validates_format_of :first_name, with: ALPHA_REGEX, if: Proc.new { |customer| customer.first_name }
  validates_format_of :last_name, with: ALPHA_REGEX, allow_blank: true
  validates_numericality_of :total_ordered, :discount, allow_blank: true
end
