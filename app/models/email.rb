class Email < ActiveRecord::Base
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i.freeze

  belongs_to :emailable, polymorphic: true

  # validates_presence_of :emailable
  validates_presence_of :address
  validates_format_of :address, with: EMAIL_REGEX
  validates_uniqueness_of :address
end
