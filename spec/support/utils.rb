class String
  def capybara
    Capybara.string(self);
  end
end 

def sample_class
  'sample-class'
end

def sample_classes_array
  ['sample-class1', 'sample-class2']
end

def sample_classes_spaced
  sample_classes_array.join(' ')
end

def sample_classes_selector
  sample_classes_array.join('.')
end

def asset_path(file)
  "/assets/#{file}";
end

def icon_path(icon)
  asset_path("icons/#{icon}");
end

def expose_methods(klass, *methods)
  klass.send(:public, *methods.flatten);
end

def scream(*args)
  puts "\n" + ("-" * 75);
  pp(*args);
  puts "-" * 75;
end