require 'spec_helper'

describe StaticFilesController do
  
  let(:good_user){ create_user! }
  
  let(:bad_user) { create_user! }
  
  let(:admin) do 
    user=create_user!
    user.admin=true
    user.save
    user 
  end
     
  let(:project)  { Factory(:project) }
  
  let(:ticket)   { Factory(:ticket,:project=>project) }
  
  let(:path)     {Rails.root+"test/fixtures/speed.txt"} 
  
  let(:asset) do
     ticket.assets.create(:asset=>File.open(path))
  end  
 
  before(:each) do
    
    good_user.permissions.create!(:action=>'view',:thing=>project)
      
  end
 
  context "users with access" do
      
 
    before(:each) do
      sign_in(:user,good_user)
    end
    
    it "can access assets in this project" do
      get :show, :id=>asset.id 
      response.body.should eql( File.read(path))
    end   
              
  end 
  
  context "users without access" do
  
    before(:each) do
      sign_in(:user,bad_user)
    end
    
    it "cannot access asset in this project" do
      
       get :show, :id=>asset.id 
       response.should redirect_to(root_path)
       flash[:alert]="The asset you were looking for could not be found." 
      
    end
    
  end 
   
  context "administrator users" do
        
        before(:each) do
           sign_in(:user,admin)          
        end
        
        it "should be able to access assets in this project" do
          get :show, :id=>asset.id 
          response.body.should eql( File.read(path))
        end
  
  end 
       
end
