module Formats
  def format_value(value, type)
    case type
      when :boolean
        value == true ? 'Yes' : 'No'
      when :money
        number_to_currency value, precision: 2
    end
  end
end