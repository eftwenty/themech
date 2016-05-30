class CustomerDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def pretty_name
    "#{object.first_name} #{object.last_name}"
  end

  def pretty_status
    object.active? ? 'Active' : 'Inactive'
  end

  def order_counts
    pending = "<span class='badge'>#{ApplicationController.helpers.pluralize(object.orders.pending.count, 'pending order')}</span>" if object.orders.pending.present?
    in_progress = "<span class='badge badge-blue'>#{ApplicationController.helpers.pluralize(object.orders.in_progress.count, 'order')} in progress</span>" if object.orders.in_progress.present?

    [pending, in_progress].join('<br/>')
  end

  def phone_numbers
    object.phones.map(&:number).join('<br/>')
  end
end
