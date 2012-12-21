require 'spec_helper'

# Also using ApplicationHelper because it includes GlobalHeper 
describe ApplicationHelper do

  expose_methods ApplicationHelper, :insert_classes!
  describe "insert_classes!" do
    CLASSES = ['new-class1', 'new-class2']
    
    shared_examples "mixing all classes" do |old_classes=nil|
      let(:partial_original) { options.dup }
      before do 
        partial_original.delete(:class);
        insert_classes!(options, *CLASSES);
      end
      specify { options[:class].should include(*CLASSES) }
      specify { options[:class].should include(*old_classes) } if old_classes
      specify { options.should include(partial_original) }
    end
    
    context "when given empty options" do 
      let(:options) { {} }
      it_should_behave_like "mixing all classes" 
    end
    
    context "when given non-empty options but without :class" do 
      let(:options) { {id: 'id'} }
      it_should_behave_like "mixing all classes" 
    end
    
    context "when given options with one class" do 
      let(:options) { {id: 'id', class: sample_class} }
      it_should_behave_like "mixing all classes", [sample_class]
    end
    
    context "when given options with multiple classes as an array" do 
      let(:options) { {id: 'id', class: sample_classes_array} }
      it_should_behave_like "mixing all classes", sample_classes_array
    end

    context "when given options with multiple classes as a spaced string" do 
      let(:options) { {id: 'id', class: sample_classes_spaced} }
      it_should_behave_like "mixing all classes", sample_classes_array
    end
    
  end 

end