module ApplicationHelper
  TITLE = "Base Title";

  def title
    (content_for?(:title)) ? "#{TITLE} | #{content_for(:title)}" : TITLE;
  end

  # Bootstrap convention: flash[type] = message
  # type = :success, :info, :alert or :error
  def flash_messages
    flash.to_a.inject("".html_safe) do |code, (type, message)|
      html_class = (type.to_sym == :alert) ? "alert" : "alert alert-#{type}";
      code + content_tag(:p, message, class: html_class);
    end
  end
  
  def icon(name, opts={})
    w, h = *{
      /^s_/ => [16, 16],
      /^g_/ => [24, 24]
    }.detect{|pattern, size| name =~ pattern }.last
    image_tag("icons/#{name}.png", {width: w, height: h, class: "icon"}.merge(opts));
  end

end
