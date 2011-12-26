require 'spec_helper'

describe Project do
  
  it "A project with a long name (max 40 chars) should be not valid" do
      
      Project.create(:name=>"x"*41).should_not be_valid
         
  end
  
 
end
