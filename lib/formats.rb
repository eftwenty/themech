module Formats
  def format_value(value, type)
    case type
      when :boolean
        value == true ? 'Yes' : 'No'
      when :money
        number_to_currency value, precision: 2
      when :time
        value.strftime('%a, %d %b %Y at %I:%M %p')
    end
  end
end