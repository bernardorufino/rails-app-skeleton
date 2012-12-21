module GlobalHelper
  
  protected
  def insert_classes!(options, *new_classes)
    new_classes.flatten!;
    classes = [];
    if options.key?(:class)
      classes = options.delete(:class);
      classes = (classes.is_a?(Array)) ? classes : classes.to_s.split(" ");
    end
    options.merge!(class: classes + new_classes)
  end
  
  # TEST
  def classes_array(classes)
    [classes].flatten.map{|c| c.split(" ") }.flatten
  end
    
  # TEST  
  def merge_classes(options)
    from, into = options[:from].dup, options[:into].dup;
    classes = classes_array(from.delete(:class) || []);
    insert_classes!(into, classes);
    into;
  end
  
  def merge_html_properties(options)
    from, into = options[:from].dup, options[:into].dup;
    into = merge_classes(from: from, into: into);
    from.delete(:class);
    into.merge(from);    
  end
  
end

[ApplicationHelper, ActionView::Base, ActiveRecord::Base, ActionController::Base].each do |klass|
  klass.send(:include, GlobalHelper);
end
