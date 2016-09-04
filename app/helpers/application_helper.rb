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

  def full_description(meta_description = '')
    if meta_description.empty?
      "Welkom op de horeca website van Recreatiebad Stappegoor. Hier kan je een kinderfeest aanvragen of contact met ons opnemen."
    else
      meta_description
    end
  end
  
  # Link to the website with the text.
  # Adds an active class if current page is active page.
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

  # Creates a list of options from the start_number upto the end number.
  def option_generator(start_number, end_number)
    # First option.
    content = content_tag(:option, start_number)

    # Second up to last option.
    (start_number + 1).upto(end_number) do |x|
      content << content_tag(:option, x)
    end

    content
  end
end
