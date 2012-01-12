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
    
    
    before_filter :find_project, :only=>[:new,:create,:show,:edit,:update]
    before_filter :find_ticket, :only=>[:show,:edit,:update]
    
    
    def find_project  
      
        @project = Project.find(params[:project_id])
        
        rescue ActiveRecord::RecordNotFound
        
        flash[:alert] = "The project you were looking for could not be found." 
        redirect_to projects_path 
    end
     
    
    
    def find_ticket
       
     @ticket = @project.tickets.find(params[:id])
     rescue ActiveRecord::RecordNotFound
        flash[:alert] = "The ticket you were looking for could not be found." 
        redirect_to project_path(@project) 
    end 
   
    
    private :find_project, :find_ticket
   
  
  
     def new 
        
        @title= "New tickets for #{@project.name} - "
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
                @title="Ticket creation errors - "
                render :new # è come render 'new' ovvero render 'new.html.erb' 
           end        
        
     end    


     def show
       @title = "Showing ticket: #{@ticket.title} - "
     end 

     
     def edit
         @title="Editing ticket: #{@ticket.title} - "       
     end   

     def update
          begin     
              if @ticket.update_attributes(params[:ticket])
                 flash[:notice]="Ticket has been updated."
                 redirect_to [@project,@ticket]
              else
                 flash[:error]="Ticket has not been updated."
                 @title="Ticket update errors - "
                 render 'edit'
              end

          rescue
               flash[:error]="Ticket has not been updated (exceptionally update error)."
               redirect_to [@project,@ticket]
          end 
     end

end
