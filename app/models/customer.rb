class Customer < ActiveRecord::Base
  ALPHA_REGEX = /\A^[A-z]+$\z/

  has_many :emails, as: :emailable
  has_one :primary_email, -> {where primary: true}, as: :emailable, inverse_of: :emailable, class_name: 'Email'

  validates_presence_of :first_name, :last_name
  validates_format_of :first_name, :last_name, with: ALPHA_REGEX
  validates_numericality_of :total_ordered, :discount, allow_blank: true
end
