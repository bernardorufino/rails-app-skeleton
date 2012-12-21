class NavProxy
  include GlobalHelper;
  CHILD_TAG = 'li';
  EMPTY_CONTENT = Proc.new { "" };

  def initialize(view_proxy, default_properties={}, &block)
    @default_properties = default_properties;
    @current_page_test = block;
    @view_proxy = view_proxy;
    @html = "";
    reset_properties;
  end
  
  def link_to(*args, &block)
    link_to(capture(&block), *args) if block_given?;
    content = args.shift;
    content = @view_proxy.link_to(content, *args, &block).html_safe;
    url = @view_proxy.url_for(args.shift);
    if current_page?(url)
      item(class: 'active') { content }
    else
      item { content }
    end
  end
  
  def item(properties={}, &block)
    set_properties(properties);
    (block_given?) ? render_item(&block) : self;
  end
  
  def to_s
    render_item { "" }
  end
  
  def divider(properties={})
    insert_classes!(properties, 'divider');
    item(properties);
  end
  
  def disabled(properties={})
    insert_classes!(properties, 'disabled');
    item(properties);
  end
  
  def header(properties={}, &block)
    insert_classes!(properties, 'nav-header');
    item(properties, &block);
  end
  
  #def head(content, *args)
  #  header(*args) { content };
  #end

  protected
  def capture(*args, &block)
    @view_proxy.capture(*args, &block);
  end
  
  def current_page?(page)
    @current_page_test.call(page);
  end
  
  def render_item(&block)
    content = capture(&block).html_safe;
    @html = @view_proxy.content_tag(CHILD_TAG, content, @properties).html_safe;
    reset_properties;
    @html;
  end
  
  # REFACTOR merge_html..., merge_...
  def set_properties(properties)
    @properties = merge_html_properties(from: properties, into: @properties);
  end
  
  def reset_properties
    @properties = @default_properties;
  end

end