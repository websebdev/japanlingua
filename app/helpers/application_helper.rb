module ApplicationHelper
  def difficulty_label(level)
    case level
    when 1
      content_tag(:span, "Beginner", class: "px-2 py-1 rounded-full bg-green-200 text-green-800")
    when 2
      content_tag(:span, "Intermediate", class: "px-2 py-1 rounded-full bg-yellow-200 text-yellow-800")
    when 3
      content_tag(:span, "Advanced", class: "px-2 py-1 rounded-full bg-red-200 text-red-800")
    else
      content_tag(:span, "Unknown", class: "px-2 py-1 rounded-full bg-gray-200 text-gray-800")
    end
  end
end
