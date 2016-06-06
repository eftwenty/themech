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

  after_save :update_discounts, if: -> obj { obj.status == 'Completed' }

  validates_presence_of :make, :model
  validates_inclusion_of :status, in: Constants::ORDER_STATUS, if: -> obj { !obj.new_record? }

  def workers_autoselect
    variety_list = self.overall_variety_list
    variety_list_size = variety_list.size
    applied_workers = []

    ### Find free workers
    workers = User.where(status: 'Free').workers

    ### Match workers and assign to order
    (variety_list_size + 1).downto(1) do
      w = (workers.select{|u| (variety_list & u.work_variety_list).size == variety_list_size} - applied_workers).first

      if w.present?
        applied_workers << w
        same = variety_list & w.work_variety_list
        variety_list -= same
      end

      break if variety_list.size == 0

      variety_list_size -= 1
    end

    {workers: applied_workers, cant_be_completed: variety_list}
  end

  def release_workers
    self.users.each do |user|
      user.update(status: 'Free') if user.orders.select{|o| o.id != self.id}.present?
    end
  end

  def update_discounts
    ordered = customer.total_ordered
    ordered = 0 if ordered.nil?

    ordered += total_price

    if ordered >= 30000 && ordered <= 50000
      discount = 3
    elsif ordered > 50000 && ordered <= 100000
      discount = 5
    elsif ordered > 100000
      discount = 7
    else
      discount = 0
    end

    customer.update(total_ordered: ordered, discount: discount)
  end
end
