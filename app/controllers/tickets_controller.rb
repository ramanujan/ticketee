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
    
     # authenticate_user! è fornito da Devise. Probabilmente eseguendo Monkey Patch 
     # di ActionController::Base
     # Funziona controllando che email e password spediti via cookie corrispondano a qualcuno presente. 
     # Se l'utente non è autenticato, evidentemente lancia un'eccezione. Per default
     # questa eccezione è catturata e gestita da Devise che ha come comportamento quello
     # di mostrare la pagina di sign-in con un messaggio flash. Questo implica che Devise 
     # redirezione ad un'altro controller l'azione corrente.  
    
    before_filter :authenticate_user!
    
    before_filter :find_project, :except=>[:index] #index() non esiste.
    
    before_filter :find_ticket, :only=>[:show,:edit,:update,:destroy]
    
    before_filter :authorize_create!, :only=>[:new,:create]

    before_filter :authorize_update!, :only=>[:edit,:update]
    
    before_filter :authorize_delete!, :only=>[:destroy]
    
    def find_project  
        
        @project = Project.for(current_user).find(params[:project_id])
        
        rescue ActiveRecord::RecordNotFound
        
        flash[:alert] = "The project you were looking for could not be found." 
        redirect_to root_path 
    
    end
     
    
    
    
    
    
    def find_ticket
       
     @ticket = @project.tickets.find(params[:id])
     
     rescue ActiveRecord::RecordNotFound
        flash[:alert] = "The ticket you were looking for could not be found." 
        redirect_to project_path(@project) 
    end 
   
    
    
    
    
    def authorize_create!
       
       
         if !current_user.admin? && cannot?("create tickets".to_sym,@project)
           
           flash[:alert]="You cannot create tickets on this project."
           redirect_to @project
         
         end
         
    end
    
    def authorize_update!
       
       
         if !current_user.admin? && cannot?("edit tickets".to_sym,@project)
           flash[:alert]="You cannot edit/update tickets on this project."
           redirect_to @project
         
         end
         
    end
    
    
    def authorize_delete!
       
       
         if !current_user.admin? && cannot?("delete tickets".to_sym,@project)
           flash[:alert]="You cannot delete tickets on this project."
           redirect_to @project
         end
         
    end
    
    
    
    
    private :find_project,
            :find_ticket,
            :authorize_create!,
            :authorize_update!,
            :authorize_delete!
   
  
  
     def new 
        
        @title= "New tickets for #{@project.name} - "
        @ticket = @project.tickets.build # Prepara un @ticket vuoto
        @ticket.assets.build()
       
        
     end


  
  
     def create

=begin

    @project e @user sono già nel database. Infatti prima che sia eseguita questa azione,
    vengono eseguiti dei filtri. Questi sono: authenticate_user! e find_project. 
    
    Quindi con la prossima linea, mi assicuro semplicemente che l'associazione tra 
    @project e @ticket si definita tramite build() che esegue new_ticket.project_id = @project.id , 
    e tra @ticket e @user ? 
    
    (1) Si noti che @user è già persistente, se creassi un nuovo ticket e invocassi
      
        ticket.user=@user allora questo metodo aggiornerebbe anche la foreign_key cioè 
        ticket.user_id = @user.id
      
    (2) Quando al costruttore passo :user=>@user viene aggiornata l'associazione, dal costruttore
        stesso
        
    
=end    
           @ticket = @project.tickets.build(params[:ticket].merge!(:user=>current_user))
           
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

=begin
  Nell'azione show(),viene preparato un array:
  @states = State.all
  Questo viene utilizzato nella view, e precisamente nel template show.html.erb dove 
  c'è un render di comments/form.html.erb in questo modo: 
  
    <%=f.select :state_id, 
                   @states.map{|state| [state.name,state.id]},
                   :selected=>@ticket.state_id%>
  
  Qui stiamo utilizzando un nuovo metodo del form-builder che è select().
  
  Module: ActionView::Helpers::FormOptionsHelper 
  method: select()
  
  
  Per capire il frammento html prodotto da questo helper facciamo deglie esempi:
  
    select("post", "category", Post::CATEGORIES, {:include_blank => true})
  
 Produrrà:
 
   <select name="post[category]">
     <option></option> # <========= Dovuto a :include_blank=>true
     <option>joke</option>
     <option>poem</option>
   </select> 
   
  Un'altro scenario ricorrente è ad esempio: 
  
    select("post",
           "person_id", 
            Person.all.collect {|p| [ p.name, p.id ] }, {:include_blank => 'None'})
  
  Che produrrà :
  
    <select name="post[person_id]">
      <option value="">None</option> # <== Dovuto a :include_blank => 'None'
      <option value="1">David</option>
      <option value="2" selected="selected">Sam</option>
      <option value="3">Tobias</option>
    </select> 
  
  
  Come si nota l'array creato nel blocco di collect() viene utilizzato per generare i campi
  <option></option>
  Si noti che una volta selezionato e spedita la form, a Rails arriverà post[:person_id]=1 
  oppure post[:person_id]=2 ecc.. 
  
  Un'altro esempio simpatico, utilizza prompt: 
  
  select("post", 
         "person_id", 
         Person.all.collect {|p| [ p.name, p.id ] }, {:prompt => 'Select Person'})
      
  e produrrà:
  
  <select name="post[person_id]">
    <option value="">Select Person</option>
    <option value="1">David</option>
    <option value="2">Sam</option>
    <option value="3">Tobias</option>
  </select> 
  
  Se vogliamo, possiamo indicare quale elemento option deve essere selezionato per default: 
  
  select("post", 
         "person_id", 
         Person.all.collect {|p| [ p.name, p.id ] }, {:selected=>2})
  
  
  <select name="post[person_id]">
    <option value="">Select Person</option>
    <option value="1">David</option>
    <option value="2" selected="selected">Sam</option>
    <option value="3">Tobias</option>
  </select>  
  
  
  oppure disabilitare un'opzione:
  
   select("post", 
         "person_id", 
         Person.all.collect {|p| [ p.name, p.id ] }, {:disabled=>2})
  
  
  <select name="post[person_id]">
    <option value="">Select Person</option>
    <option value="1">David</option>
    <option value="2" disabled="disabled">Sam</option>
    <option value="3">Tobias</option>
  </select>  
  
  Nel nostro esempio : 
  
    <%=f.select :state_id, 
                   @states.map{|state| [state.name,state.id]},
                   :selected=>@ticket.state_id%>
  
  Questa f.select() qui, equivale a: 
  
    select :comment,
           :state_id, 
           @states.map{|state| [state.name,state.id]},
           :selected=>@ticket.state_id
            
  
  E supponendo che gli stati siano ad esempio 'New', 'Open', 'Closed' Allora: 
  
  
  <select name="comment[state_id]">
    <option value="1">New</option>
    <option value="2" selected="selected">'Open'</option>
    <option value="3">Closed</option>
  </select>  
  
  
  
  
=end
     
     
     def show
       
       @title = "Showing ticket: #{@ticket.title} - "
       @comment = @ticket.comments.build
       @states = State.all
           
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
  
     def destroy
          @ticket.destroy
          flash[:notice]="Ticket has been deleted."
          redirect_to @project 
     end


end
