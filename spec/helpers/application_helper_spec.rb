require 'spec_helper'

describe ApplicationHelper do

  describe "title" do
  
    context "when view doesn't specify custom title'" do
      subject { helper.title }
      it { should eq(ApplicationHelper::TITLE) }
    end
    
    context "when view specifies custom title" do
      before { view.provide :title, "custom" }
      subject { helper.title }
      it { should match(/custom/) }
      it { should match(ApplicationHelper::TITLE) }    
    end
  
  end

  describe "flash_messages" do
  
    context "when no flash is set" do
      specify { helper.flash_messages.should be_empty }
    end
  
    [:success, :info, :alert, :error].each do |type|
    
      context "when flash[#{type}] is assigned" do
        before { controller.flash.now[type] = "message" }
        subject { helper.flash_messages.capybara }
        
        it { should have_selector('.alert', text: "message") }
        it { should have_selector(".alert-#{type}") } unless type == :alert
              
      end
      
    end
    
    # In fact, plural flashes, but keepin' it simple, otherwise
    # we could use Array#combination 4 times
    t1, t2 = :error, :info; # Not :alert
    context "when flash #{t1} and #{t2} are assigned" do
        before do
          controller.flash.now[t1] = t1.to_s;
          controller.flash.now[t2] = t2.to_s;
        end
        subject { helper.flash_messages.capybara }
        it { should have_selector(".alert.alert-#{t1}", text: t1.to_s) }
        it { should have_selector(".alert.alert-#{t2}", text: t2.to_s) }
    
    end
   
  end
  
  describe "icon" do
    
    shared_examples "icon" do |icon, opts={}|
      width, height = *opts[:size];
      subject { helper.icon(icon, opts[:provide] || {}).capybara }
      let(:img) { subject.find('img') }
      
      it { should have_selector('img.icon') }
      specify { img['width'].should eq(width.to_s) }
      specify { img['height'].should eq(height.to_s) }
      specify { img['src'].should eq(icon_path("#{icon}.png")) }    
    end
    
    it_should_behave_like "icon", 'g_play', size: [24, 24];
    it_should_behave_like "icon", 's_resultset_next', size: [16, 16];
    
    context "when size provided" do
      it_should_behave_like "icon", 's_resultset_next', size: [31, 42], provide: {
        width: 31,
        height: 42
      };      
    end    
  
  end
  
  describe "button" do
  
    shared_examples "stylized button" do
      it { should have_selector('button.btn[type="button"]', text: "Sample") }  
    end
  
    context "when given only content" do
      subject { helper.button("Sample").capybara }  
      it_should_behave_like "stylized button"
    end
    
    # :primary, :info, :success, :warning, :danger, :inverse, :link
    type = :primary; 
    context "when given type and content" do
      subject { helper.button(type, "Sample").capybara }
      it_should_behave_like "stylized button"
      it { should have_selector(".btn-#{type}", text: "Sample") }
    end
    
    context "when given content and extra class as string" do
      subject { helper.button("Sample", class: 'extra-class').capybara }
      it_should_behave_like "stylized button"
      it { should have_selector('.extra-class') }
    end
    
    context "when given content and extra classes as string" do
      subject { helper.button("Sample", class: 'extra-class1 extra-class2').capybara }
      it_should_behave_like "stylized button"
      it { should have_selector('.extra-class1.extra-class2') }
    end
  
    context "when given content and extra classes as array" do
      subject { helper.button("Sample", class: ['extra-class1', 'extra-class2']).capybara }
      it_should_behave_like "stylized button"
      it { should have_selector('.extra-class1.extra-class2') }
    end
  
  end

end