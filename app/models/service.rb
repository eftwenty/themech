class Service < ActiveRecord::Base
  include Constants
  VARIETY = %w(Electricity Body Engine Etc)

  has_and_belongs_to_many :orders

  before_validation :calculate_price
  before_update :service_changed, if: -> obj { obj.changed? }
  before_destroy :service_deleted

  acts_as_taggable_on :variety

  validates_presence_of :name, :man_hours, :variety_list
  validates_format_of :name, with: ALPHA_REGEX
  validates_numericality_of :man_hours, :price

  scope :pending, -> { where(pending: true) }
  scope :available, -> { where.not(pending: true) }

  def service_changed
    ServiceMailer.changed_service(self).deliver
  end

  def service_deleted
    ServiceMailer.changed_service(self).deliver
  end

  private

  def calculate_price
    self.price = self.man_hours * MAN_HOUR_PRICE
  end
end
