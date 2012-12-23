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
  
  def icon(name, attrs={})
    if name =~ /^g_(white_)?(.+)$/
      # Cannot invert orders, 2 lines below, because #gsub sets new $1
      classes = ($1) ? ['icon-white'] : [];
      classes << "icon-#{$2.gsub('_', '-')}";
      content_tag(:i, "", insert_classes(attrs, classes));
    else
      image_tag("icons/#{name}.png", insert_classes(attrs, 'icon'));
    end
  end
  
  def icon_text(icon, text, attrs={})
    "#{icon(icon, attrs)} #{text}".html_safe;
  end
  
  def text_icon(text, icon, attrs={})
    "#{text} #{icon(icon, attrs)}".html_safe;
  end
  
  # button(type, content(, options))
  # button(content(, options))
  # See spec for more details on usage
  def button(*args)
    options = (args.last.is_a?(Hash)) ? args.pop : {};
    content = args.delete_at(1).try(:to_s) || args.shift.to_s;
    classes = (args.first) ?  ['btn', "btn-#{args.first}"] : ['btn'];
    options = insert_classes(options, classes);
    button_tag(content, {type: 'button'}.merge(options));
  end
  
  # Rails default button_to turns into form_button_to
  ActionView::Base.send :alias_method, :form_button_to, :button_to
  
  def button_to(*args, &block)
    return button_to(capture(&block), *args) if block_given?
    content, options, html_options = *args;
    return link_to(content, options, {class: 'btn'}) if not html_options;
    html_options = insert_classes(html_options, 'btn');
    link_to(content, options, html_options);
  end

  def nav(options={}, &block)
    itens_properties = options.delete(:itens) || {};
    proxy = NavProxy.new(self, itens_properties, &method(:current_page?));
    tag = options.delete(:tag) || 'ul';
    content = (block_given?) ? capture(proxy, &block) : "";
    nav = (options.key?(:nav)) ? options.delete(:nav) : true;
    options = insert_classes(options, 'nav') if nav;
    content_tag(tag, content, options);
  end    
  
end
