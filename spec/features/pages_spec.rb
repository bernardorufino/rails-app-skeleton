require 'spec_helper'

describe PagesController do
  
  shared_examples "existing" do |p|
    before { visit page_path(p) }
    subject { page }
    it { should have_selector('html') }
  end
  
  describe "home" do 
    it_behaves_like "existing", :home
  end
  
end
