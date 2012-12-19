module ApplicationHelper
  TITLE = "Base Title";

  def title
    (content_for?(:title)) ? "#{TITLE} | #{content_for(:title)}" : TITLE;
  end

  def flash_messages
    flash.to_a.inject("".html_safe) do |code, (type, message)|
      code + content_tag(:p, message, class: "alert alert-#{type}")
    end
  end

end
