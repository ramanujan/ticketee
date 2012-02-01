require 'spec_helper'


=begin
         NOTA BENE: Tutto ciò che si trovi nel blocco before(:each) viene eseguito 
                    nello stesso scope dell'oggetto creato per l'esempio. Inoltre a
                    partire dai blocchi before più esterni, e andando verso l'interno
                    è come se fosse un unico blocco before(:each) 
                    
                    In particolare questo ci permette per ogni esempio di sfruttare 
                    con let un metodo memoized.
                    
=end

describe TicketsController do
     
     let(:user){ create_user! }
     let(:project){ Factory(:project) }
     let(:ticket){ Factory(:ticket, :user=>user, :project=>project) }

     context "standard users (logged in) " do
       
          before(:each) do
           
            sign_in(:user,user) 
            
          
          end
      
          it "cannot access a ticket for a project on which she hasn't access" do
            
            get :show, :id=>ticket.id, :project_id=>project.id # 
            response.should redirect_to root_path
            flash[:alert].should eql("The project you were looking for could not be found.") 
          
          end
    
          context("with permission to view the project") do
            
            before(:each) do
               
              Permission.create! :user=>user,:thing=>project,:action=>"view"
                 
            end
            
           
            def cannot!(resource,msg) # Un helper
                
                response.should redirect_to project_path(resource) 
                flash[:alert].should eql(msg)
            
            end
            
            
            it "cannot begin to create a ticket" do
              
               get :new, :project_id=>project.id 
               cannot!(project,"You cannot create tickets on this project.")
               
            end
   
           
           
            it "cannot edit tickets without permission" do
              
                get :edit, :project_id=>project.id,:id=>ticket.id 
                cannot!(project,"You cannot edit/update tickets on this project.")      
            end
            
            it "cannot update a ticket without permission" do
            
                put :update, :project_id=>project.id, :id=>ticket.id, :ticket=>{}
                cannot!(project,"You cannot edit/update tickets on this project.") 
                
            end
            
            it "cannot delete a ticket without permission" do
              
                delete :destroy, :project_id=>project.id, :id=>ticket.id 
                cannot!(project,"You cannot delete tickets on this project.")
              
            end
   
          end 
    
    
     end     
     
end
              
         
 