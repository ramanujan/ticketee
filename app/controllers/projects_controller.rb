class ProjectsController < ApplicationController

 def index
      
      @projects = Project.all
      @title="home - "   
   
 end

=begin
         In new.html.erb è presente il codice per generare la seguente form : 
       
       
       <form accept-charset="UTF-8" 
             action="/projects" 
             class="new_project" 
             id="new_project" 
             method="post">
             
         <div style="margin:0;padding:0;display:inline">
            
            <input name="utf8" type="hidden" value="&#x2713;" />
            
            <input name="authenticity_token" type="hidden" 
                   value="nVkBxh2SvfUaRmTWawLNwiTomMxcOv4ZCuPqQyB6Hfo=" />
         </div>

      
       <div id="form_for_project">
      
               <div class="label_cell">
            
                    <label for="project_name">Project Name</label>
              
               </div>
    
             <div class="input_cell">
              
                  <input id="project_name" name="project[name]" size="30" type="text" />
            
             </div> 
           
             <div>
             
                 <input name="commit" type="submit" value="Create Project" />

             </div> 
        
        </div> 

</form>  

=end

 
 def new
      
      @project = Project.new 
   
 end 


=begin
       Quando impegnemo la form generata da new, arrivano allo stack d'attivazione di Rails parecchie
       informazioni. In particolare arrivano:
       
       ...;&project[name]="valore inserito"&commit="Create Project"  
       
       Lo stack d'attivazione crea un'istanza di HashWithIndifferentAccess, che è sostanzialmente differente
       da un normale Hash di Ruby, perchè possiamo riferirci ad un valore contenuto nello Hash specificando 
       in maniera indifferente sia un Symbol che una String. 
       
       {
        "commit" => "Create Project",
        "action" => "create",
        "project"=> {
                     "name" => "TextMate 2"
                     }  

        In particolare come si nota qui sopra, con la variabile project[name] crea un hash individuato da "project"
        questo Hash modella i dati che arrivano dalla form:
        
        params[:project][:name] ==> Il campo nome


=end


def create
    
    @project = Project.new params[:project]
    
    if @project.save
       
       flash[:notice]="Project has been created."
       redirect_to @project # È come redirect_to project_path(@project.id)  
    
    else
       flash[:error]="Project has not been created. " 
       render 'new' # È come render "new.html.erb" oppure render "projects/new.html.erb"
    end
    
    
end


def show

  @project = Project.find(params[:id])
  @title="#{@project.name} - Projects - "
end


def edit 
   
   @project = Project.find(params[:id])
     
end



=begin
      Vale la pena di spendere due parole per il metodo update_attributes(). Questo metodo se si verifica 
      un problema dovuto alla connessione lancia
      una bella eccezione. Altrimenti ritorna false, se le modifiche portano ad un oggetto non valido, 
      oppure ritorna true se le modifiche sono ok,
      non violano cioè le validazioni. Infatti questo metodo invoca save().  
       
=end  
  


def update

     @project = Project.find(params[:id])
     
    if @project.update_attributes(params[:project])
        flash[:notice]="Project has been updated."
        redirect_to @project
    else
        flash[:error]="Project has not been updated."
        render 'edit'
    end
     
end


end