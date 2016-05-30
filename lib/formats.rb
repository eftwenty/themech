module Formats
  def format_value(value, type)
    case type
      when :boolean
        value == true ? 'Yes' : 'No'
      when :time
        value.strftime('%a, %d %b %Y at %I:%M %p')
      when :only_time
        value.strftime('%I:%M %p')
      when :date
        value.strftime('%a, %d %b %Y')
      when :money
        value.nil? ? '$0.00' : number_to_currency(value)
    end
  end
end