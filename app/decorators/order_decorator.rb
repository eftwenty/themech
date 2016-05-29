class OrderDecorator < Draper::Decorator
  delegate_all

  def pretty_variety
    object.overall_variety.join(', ')
  end
end