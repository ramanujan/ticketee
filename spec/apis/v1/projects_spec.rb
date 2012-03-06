require "spec_helper"

# Per un commento sulle cose presenti in questo spec
# si consulti DESIGNING_AN_API


describe "api/v1/projects", :type=>:api do

  let(:user){ create_user! }    
  let(:token){ user.authentication_token }   
  
  before(:each) do
    @project1 = Factory(:project)  
    @project2 = Factory(:project, :name=>"Access Denied")
    user.permissions.create!(:action=>"view",:thing=>@project1)
    
  end 
   
  context "projects viewable by this user " do
    
    let(:url){ "/api/v1/projects" }    
     
    it "json" do
      get "#{url}.json" # <== Si noti che qui è presente già il concetto di negoziazione delle risorse 
      projects_json = Project.for(user).all.to_json
      last_response.body.should eql(projects_json)
      last_response.status.should eql(200)
      projects = JSON.parse(last_response.body)
     
      projects.any? do |project|
        project["name"] == "Ticketee"
      end.should be_true 
      
      projects.any? do |project|
        project["name"] == "Access Denied"
      end.should be_false 
    
    end   
  
    it "xml" do
      get "#{url}.xml", :token=>token
      last_response.body.should eql( Project.for(user).to_xml )
      projects = Nokogiri::XML(last_response.body)
      projects.css("project name").text.should eql("Ticketee")
     # p "Nokogiri::XML ==> #{projects}" 
    end
  
  end  

end


  