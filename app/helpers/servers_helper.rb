module ServersHelper
  def sort_link(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    icon = sort_direction == "asc" ? "data-feather='arrow-up'" : "data-feather='arrow-down'"
    icon = column == sort_column ? icon : ""
    link_to "#{title}<span class='sorting-icon' #{icon}></span>".html_safe, {column: column, direction: direction}
  end
end