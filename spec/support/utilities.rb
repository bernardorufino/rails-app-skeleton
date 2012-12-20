class String
  def capybara
    Capybara.string(self);
  end
end 

def asset_path(file)
  "/assets/#{file}";
end

def icon_path(icon)
  asset_path("icons/#{icon}");
end

def scream(*args)
  puts "\n" + ("-" * 75);
  pp(*args);
  puts "-" * 75;
end