module ApplicationHelper
  ALPHA_REGEX = '/^[A-z]+$/'

  def section_header label
    content_tag :h4 do
      content_tag(:strong, label) +
        content_tag(:hr)
    end
  end
end
