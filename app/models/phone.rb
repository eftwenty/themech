class Phone < ActiveRecord::Base
  include Constants
  belongs_to :phoneable, polymorphic: true

  validates_presence_of :number
  validates_format_of :number, with: PHONE_NUMBER_REGEX
end