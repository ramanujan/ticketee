class ProjectsController < ApplicationController
 
=begin 

   Tutte le azioni (meno che show e index) possono essere accedute se e solo se l'utente è un admin.
   Se l'utente non è admin queste azioni sono bloccate e l'utente è rediretto a root_path con il
   messaggio d'errore. 
   
=end 

 before_filter :authorize_admin!, :except=>[:show,:index] # In application_controller.rb
 
=begin
       Per due azioni ( show(), index() ) non è richiesto di essere admin ma di essere loggati 
       Se per caso l'utente non è loggato e richiede una di queste azioni deve essere rediretto verso
       pagina di login. 
=end 
 
 before_filter :authenticate_user!,:only=>[:index,:show] # definito da Devise, serve per vedere se l'utente ha eseguito login. 
 
 
 before_filter :find_project, :only=>[:show,:edit,:update,:destroy] #Potresti utilizzare anche :except
 
 def find_project
          
=begin  @project = Project.find(params[:id])
        
        Questa linea è stata commentata, poichè adesso in tutte le operazioni che implicano 
        reading di un progetto dal database, devo controllare i permessi. In questo caso allora,
        voglio restringere una find() in modo che dal database vengano letti solo i record su
        cui l'utente corrente ha dei permessi.
        
        Questo obiettivo si raggiunge con gli SCOPEs di ActiveRecord. Si deve cioè utilizzare
        ActiveRecord#scope. Questo metodo sostanzialmente fornisce un meccanismo per definire 
        un metodo, che possiamo invocare nella nostra classe del MODEL (Project),oppure in una collezione
        relativa ad un'associazione (che comunque si comporta come una classe del MODEL), per ritornare
        un sottoinsieme di records e non tutti quelli possibili. 
        
            
=end
        @project = Project.for(current_user).find(params[:id]) 
        rescue ActiveRecord::RecordNotFound
         flash[:alert] = "The project you were looking for could not be found."
         redirect_to projects_path 
 end
 
 private :find_project
 

 def index
      
      @projects = Project.for(current_user).all
      @title="Home - "   
   
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
      @title="Create a new project - "
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
       @title="Project creation errors - "
       render 'new' # È come render "new.html.erb" oppure render "projects/new.html.erb"
    end
    
    
end


def show
    
    @title="Showing project: #{@project.name} - "
     
end


def edit 
      
     @title="Editing project: #{@project.name} - "
end



=begin
      Vale la pena di spendere due parole per il metodo update_attributes(). Questo metodo se si verifica 
      un problema dovuto alla connessione lancia
      una bella eccezione. Altrimenti ritorna false, se le modifiche portano ad un oggetto non valido, 
      oppure ritorna true se le modifiche sono ok,
      non violano cioè le validazioni. Infatti questo metodo invoca save().  

      Dato questo duplice comportamento in caso do errore ho deciso di catturare l'eccezione e di rimandare
      alla home page con flash[:error]           
=end  
  


def update

    
begin     
    
    if @project.update_attributes(params[:project])
        flash[:notice]="Project has been updated."
        redirect_to @project
    else
        flash[:error]="Project has not been updated."
        @title="Project update errors - "
        render 'edit'
    end

rescue
       flash[:error]="Project has not been updated (exceptionally update error)."
      
       redirect_to root_path
end 
 
     
end



=begin
         Attenzione: Non si è stabilita nessuna associazione parent-child tra i ticket e gli utenti. 
                     Questo significa che alla cancellazione di un utente, non seguirà la cancellazione
                     dei ticket associati.      

                     Invece tra Project e Ticket esiste tale tipo di associazione. Allora alla
                     cancellazione di un Porject anche con Project.destroy() seuirà la cancellazione
                     dei tickets associati.   

=end
def destroy
     
     @project.destroy
     
     flash[:notice]="Project has been deleted."
     
     redirect_to root_path 
      
end


end
