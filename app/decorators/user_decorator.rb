class UserDecorator < Draper::Decorator
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

  def pretty_roles
    object.roles.map(&:name).join(', ')
  end

  def pretty_work_varieties
    object.work_variety.map(&:name).join(', ')
  end

  def phone_numbers
    object.phones.map(&:number).join('<br/>')
  end
end
