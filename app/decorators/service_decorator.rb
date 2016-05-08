class ServiceDecorator < Draper::Decorator
  delegate_all

  def pretty_variety
    object.variety.map(&:name).join(', ')
  end
end