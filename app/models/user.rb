class User < ActiveRecord::Base
  ALPHA_REGEX = /\A^[A-z]+$\z/

  has_many  :emails, as: :emailable, dependent: :destroy
  has_one   :primary_email, -> {where primary: true}, as: :emailable, inverse_of: :emailable, class_name: 'Email'

  accepts_nested_attributes_for :emails, allow_destroy: true

  validates_presence_of :first_name, :last_name
  validates_format_of :first_name, :last_name, with: ALPHA_REGEX
  # validates_associated :primary_email
  # validates_length_of :primary_email, {maximum: 1}

    # validates_uniqueness_of :primary_email

  # validates :primary_email, length: { maximum: 1 }
end
