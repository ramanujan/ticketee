=begin

      Si noti sotto, dentro l'azione create(), abbiamo utilizzato redirect_to e abbiamo specificato
      come parametro un array [@project, @ticket]. Lo stesso array passato per form_for(). Si noti
      che Rails ispeziona ogni array passato agli helpers, come ad esempio:
       
       form_for(),
       link_to(), 
       redirect_to(),
      
      per determinare i giusti URLs nel caso di risorse nested. In particolare eseguendo 
      redirect_to [@project,@ticket] Rails determina che si vuole l'URL generato da
      
       project_ticket_path(@project,@ticket)
=end

class TicketsController < ApplicationController
    
    
    before_filter :find_project, :only=>[:new,:create,:show]
    
    
    def find_project  
      
        @project = Project.find(params[:project_id])
        
        rescue ActiveRecord::RecordNotFound
        
        flash[:alert] = "The project you were looking for could not be found." 
        redirect_to projects_path 
    end
   
    
    private :find_project
   
  
  
     def new 
        
        @title= "New - Tickets - #{@project.name}"
        @ticket = @project.tickets.build
         
     end


  
  
     def create
              
           @ticket = @project.tickets.build params[:ticket]
           
           if @ticket.save 
                flash[:notice]="Ticket has been created."
                redirect_to [@project, @ticket] 
                #redirect_to project_ticket_path(@project,@ticket)
           else
               
                flash[:error]="Ticket has not been created."
                render :new # è come render 'new' ovvero render 'new.html.erb' 
           end        
        
     end    


     def show
       
       @ticket = @project.tickets.find(params[:id])
       
       rescue ActiveRecord::RecordNotFound
        flash[:alert] = "The ticket you were looking for could not be found." 
        redirect_to project_path(@project) 
     
     end 


end
