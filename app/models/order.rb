class Order < ActiveRecord::Base
  include Constants

  belongs_to :customer
  has_and_belongs_to_many :services
  has_and_belongs_to_many :users

  accepts_nested_attributes_for :services, allow_destroy: true

  acts_as_taggable_on :overall_variety

  scope :pending, -> { where(status: 'Pending') }
  scope :canceled, -> { where(status: 'Canceled') }
  scope :in_progress, -> { where(status: 'In progress') }
  scope :completed, -> { where(status: 'Completed') }

  before_create do
    self.status = 'Pending'
    self.overall_variety_list = self.services.map(&:variety_list).flatten.uniq
  end

  after_create do
    self.total_price = self.services.sum(:price)
    self.save
  end

  validates_presence_of :make, :model

end
