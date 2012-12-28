# TODO: To menu, .nav optional as a parameter (see BNIP2P) and customizable .active
# TODO: Add Breadcrumb support ?
# TODO: Revise title to expects title as argument and return also tag for content
# TODO: Implement AppHelper#title(name)
# See https://github.com/xdite/bootstrap-helper
class ApplicationController < ActionController::Base
  protect_from_forgery
end
