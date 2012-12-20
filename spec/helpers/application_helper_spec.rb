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
        subject { helper.flash_messages }
        
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
        subject { helper.flash_messages }
        
        it { should have_selector(".alert.alert-#{t1}", text: t1.to_s) }
        it { should have_selector(".alert.alert-#{t2}", text: t2.to_s) }
    
    end
   
  end # describe "flash_messages" do

end