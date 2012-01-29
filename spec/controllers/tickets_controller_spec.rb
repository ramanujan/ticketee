require 'spec_helper'

describe TicketsController do
    
    let(:user) do
           create_user! 
        end
       
    let(:project) do
         project = Factory(:project)
    end
   
    let(:ticket) do
         Factory(:ticket,:project=>project,:user=>user)
    end 
   
   context "standard (signed in) user" do
     
     it "cannot access a ticket for a project" do
       
         sign_in(:user,user) # Login utente di default
         get :show, :id=>ticket.id, :project_id=>project.id 
=begin
       Si noti che :id=>ticket.id          genera un ticket di default presente nel database  di test
       e anche     :project_id=>project.id genera un project di default presente nel database di test
       L'utente di default non ha alcun permesso sul ticket. 
         
=end 
       response.should redirect_to root_path
       flash[:alert].should eql("The project you were looking for could not be found.")
       
     end
     
     
   end

end
