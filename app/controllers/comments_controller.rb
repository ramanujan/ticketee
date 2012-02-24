=begin
       OSSERVAZIONE 1
       
       La classe del MODEL Comment è in associazione many<->to<->one con User e anche con Ticket. 
       In pratica quando creiamo un commento, questo deve essere associato sia ad un'istanza di User che
       di Ticket. 
       
       -------------------------------------------------------------------------------------------------
       
       OSSERVAZIONE 2 ( RIPASSO DI UNO DEI WORK-FLOW DELL'APPLICAZIONE )
       
       Prima di ogni azione del controller Ticket, viene invocato find_project(), che esegue:
       
        @project = Project.for(current_user).find(params[:project_id])         
       
       In pratica il metodo Project#for() esegue: 
       
         def self.for(user)
     
           user.admin? ?  Project : Project.readable_by(user)
        
         end   
   
       Quindi il progetto verrà cercato nell'intera tabella Project se l'utente è loggato come amministratore,
       oppure in una proiezione, un sottoinsieme della tabella: 
       
         scope :readable_by, lambda{ |user| joins(:permissions).
                                      where(:permissions=>{:action=>"view",:user_id=>user.id})}  
       
       quindi un utente come prima cosa per eseguire una qualsiasi azione, deve essere loggato nel sistema e
       poi, per eseguire le opportune azioni deve essere o amministratore oppure deve avere il pernesso 
       "view" nella white list. 
       L'utente che abbia le credenziali necessarie per visualizzare un progetto, automaticamente potrà 
       anche vederne i ticket associati. Tuttavia per creare, aggiornare, oppure cancellare un ticket, 
       un utente deve evere i permessi adeguati, altrimenti non lo potrà fare.  
                
       -------------------------------------------------------------------------------------------------------
      
       OSSERVAZIONE 3
       
       Se si osserva il modello di business, si noterà che esistono delle associazioni tra le classi del
       dominio come è ovvio che sia. Tuttavia le relazioni parent-child sono quasi del tutto assenti.
       Vediamo un pochettino le associazioni e commentiamo: 
       
        1) User ONE <===>TO<===>MANY Ticket
       
       In quest'associazione non è presente la semantica parent-child. Infatti se per caso cancello un utente
       non voglio cancellare tutti i ticket creati da quest'ultimo. Infatti altre istanze di User potrebbero 
       essere a lavoro su di un ticket aperto da un utente. Questo Ticket può avere anche molti commenti associati
       e vedremo poi per quanto riguarda lo stato.  
       
        2) User ONE<===>TO<===>MANY Permission 
       
       In questo secondo caso è presenta l'associazione parent-child. Quindi se cancello un'istanza di classe User, 
       allora dovrà altresì cancellare anche tutti i permessi associati. Questo significa come abbiamo visto, 
       cancellare il record relativo all'utente nella tabella permissions. 
       
        3) Project ONE<===>TO<===>MANY Ticket 
       
       In questo terzo caso invece esiste l'associazione parent/child come atteso. Infatti una volta eliminata l'istanza
       di un progetto non ha molto continuare a lavorare sui suoi tickets. 
       
        4)  Ticket ONE<===>TO<===>MANY Asset 
        
       In questo quarto caso, esiste l'associazione parent/child. La cancellazione del file (fisico) viene eseguita con una
       callback. In pratica si mette asset a nil e quindi si esegue un aggiornamento.  
        
        5)  Ticket ONE<===>TO<===>MANY Comment 
        
       COMMENT ??? CHE DIRE? VOGLIAMO METTERCI UNA BELLA ASSOCIAZIONE PARENT-CHILD ??  
        
        6) User Comment ??     
        
        ______________________________________________________________________________________
        
        OSSERVAZIONE:
        
        In show.html.erb relativo all'azione show() del controller TicketsController, è presente senza dubbio 
        questo pezzo di codice, che mostra quanto cazzo è potente RoR :
        
         <div id="comments">
       
           <%if @ticket.comments.exists? %>
           
             <%=render @ticket.comments.select(&:persisted?)%>
           
           <%else%>
             There are no comments for this ticket
           <%end%> 
       
       </div>
        
        Inanzitutto diciamo che @ticketcomments.exists? produrrà qualcosa di simile a questo: 
        
         SELECT "comments"."id" FROM "comments" WHERE ("comments".ticket_id = 1) LIMIT 1
         
        Questa è una cosìdetta light query per vedere se il ticket possiede in effetti dei commenti associati.
        Si tratta di una query molto light, perchè richiede solo id e limita i risultati ad una sola riga. Non
        istanzia nulla, serve solo per vedere se ha dei commenti associati. 
        
        Se avessimo utilizzato empty? queto metodo avrebbe eseguito una select molto diversa. Avrebbe infatti caticato 
        l'intera lista di commenti e quindi controllato se l'array fosse vuoto. 
        
        @ticket.comments.select(&:persisted?) equivale a : 
        
         @ticket.comments.select do |ticket| 
            
                ticket.persisted? 
           
         end
        
        
      Ricordiamo che select() per ogni elemento della lista esegue il blocco, e se il blocco torna true l'elemento è 
      inserito nell'array risultante. Questo array risultante è poi dato in pasto a render(). render() utilizzato in questa 
      forma andrà a presentare un parziale per ogni elemento dell'array, questo parziale lo desume dal nome della classe 
      del primo oggetto dell'array. In questo caso la classe è Comment, quindi per ogni elemento dell'array render andrà 
      a presentare _comment.html.erb dentro views/comments. La cosa fantastica è che gli passa una variabile locale (al parziale)
      e questa variabile locale è chiamata comment,ed è ovviamente l'istanza corrente.
      
      Andiamo allora ad analizzare cosa abbiamo messo dentro views/comments/_comment.html.erb:
      
       <%=div_for(comment) do%>
         <p>
           <%=comment.user%>
        </p>
        
        <p>
          <%=simple_format(comment.text)%> 
        </p>
   
        <hr /> 
      
       <%end%>

     L'helper div_for() è davvero simpatico. Genera un tag <div> attorno al contenuto generato nel blocco, e imposta anche id e class
     del div bsandosi su quanto passato:           


=end

class CommentsController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :find_ticket
  
  def find_ticket
       
      begin
        @ticket = Ticket.find(params[:ticket_id])  
        @project = @ticket.project 
      rescue
        flash[:alert] = "The ticket you were looking for could not be found." 
        redirect_to project_path(@project)   
      end
  end
  
  
  # Azione accesa dalla form integrata in show.html.erb relativa al controller ticket.  
  # Viene invocato per mezzo di ticket_comments(@ticket) con verbo POST 
  # Si ricordi che Comment presenta due associazione many=>to=>one. Una con User e l'altra con Ticket
  
  def create
    
    @comment = @ticket.comments.build(params[:comment].merge(:user=>current_user) ) 
    
    if @comment.save 
                flash[:notice]="Comment has been created."
                redirect_to [@ticket.project, @ticket] 
           else
               
                flash[:error]="Comment has not been created."
                @title="Adding comment errors - "
                render :template => "tickets/show" 
                # Utilizziamo :template per presentare un template relativo ad un'azione di un'altro controller
                # possiamo fornire sia un path assoluto che relativo. Quello relativo si riferisce a /app/views
                
           end        
        
            
    
  end
     
  private :find_ticket 
  
       




end
