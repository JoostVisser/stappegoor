module ApplicationHelper

  # Returns the full title on a per-page basis
  def full_title(page_title = '')
    base_title = "Horeca Recreatiebad Stappegoor"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  # Link to the website with the text.
  # Adds an active class if current page is linked page.
  def nav_link(link_text, link_path)
    class_name = current_page?(link_path) ? 'active' : nil

    content_tag(:li, class: class_name) do
      link_to link_text, link_path
    end
  end

  # Link to the website with the text.
  # Adds an active class if current page is linked page.
  def breadcrumb_link(link_text, link_path)
    class_name = current_page?(link_path) ? 'active' : nil

    content_tag(:li, class: class_name) do
      link_to link_text, link_path
    end
  end
end
