class Service < ActiveRecord::Base
  include Constants
  VARIETY = %w(Electricity Body Engine Etc)

  before_save :calculate_price

  acts_as_taggable_on :variety

  validates_presence_of :name, :man_hours, :variety_list
  validates_format_of :name, with: ALPHA_REGEX
  validates_numericality_of :man_hours, :price

  private

  def calculate_price
    self.price = self.man_hours * MAN_HOUR_PRICE
  end
end
