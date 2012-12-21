class RailsAppSkeleton::Application
  
  # Include GlobalHelper
  require "#{config.root}/app/helpers/global_helper";
  
  # Core extension
  require "#{config.root}/lib/support/core_ext"
  
  # Extend Sass
  # require "#{config.root}/app/assets/stylesheets/sass";
  
end
    