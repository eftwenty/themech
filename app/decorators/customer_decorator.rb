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
    pending = "<span class='badge'>#{object.orders.pending.count}</span>"
    in_progress = "<span class='badge badge-blue'>#{object.orders.in_progress.count}</span>"

    [pending, in_progress].join(' ')
  end
end
