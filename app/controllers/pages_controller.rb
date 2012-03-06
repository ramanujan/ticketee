class PagesController < ApplicationController

 def home
      
      render :file=>"/home/domenico/file.txt",
      :layout=>true
            
      
      
 end


 def demo_jquery
      
        
    
 end


=begin
         Per quanto riguarda form_helpers sono sostanzialmente interessato a
         
         1) form_for(), per creare delle form attorno ad una classe del MODEL
         2) form_tag(), per creare form generiche. Utile quando devi rappresentare la creazione di una risorsa complessa
         3) fields_for(), con nested attributes, utile per rappresentare la creazione di una risorsa complessa.
         4) Fai un commento su form_for utilizzato con label. 
         
         Vedremo nei vari esempi cosa s'intende per risorsa complessa. 
=end


=begin
         Basic Form 
           
         Un helper per creare form di base è form_tag(). Vediamone subito un esempio:   
         La view associata a quest'azione, e cioè 
          
               <%= form_tag do %>
               <%end%> 
         
        produce il seguente snippet HTML:     
        
               <form accept-charset="UTF-8" 
                     action="/pages/demo_form_1" 
                     method="post">
           
               <div style="margin:0;padding:0;display:inline">
           
                  <input name="utf8" type="hidden" value="&#x2713;" />
                  <input name="authenticity_token" 
                         type="hidden" 
                         value="aXMLwQKFyGcAR6hIsUvYbPhvHfyL+5STu1kvI9Q6Szc=" />
               </div>
        
               </form>        

          Now, you’ll notice that the HTML contains something extra: 
          a div element with two hidden input elements inside. This div is important, 
          because the form cannot be successfully submitted without it. 
          The first input element with name utf8 enforces browsers to properly respect your 
          form’s character encoding and is generated for all forms whether their actions 
          are “GET” or “POST”. T
          
          he second input element with name authenticity_token is a security feature of 
          Rails called cross-site request forgery protection, and form helpers generate 
          it for every non-GET form (provided that this security feature is enabled). 
          
          You can read more about this in the Security Guide.   
          
                   
=end

 def demo_form_1  

       @title = "Demo form 1 - "

 end


=begin
       
       form_tag() può essere efficaciemente utilizzato quando non vogliamo creare delle form 
       attorno ad una classe del MODEL, ma desideriamo costruirne l'azione (l'attributo action)
       e ogni campo manualmente.Ad esempio qui sotto andiamo a creare una delle form più diffuse 
       in generale, e cioè una serch form.Il seguente pezzo di codice: 
       
                <%= form_tag(search_path,:method=>"get") do %>
                 
                     <%=label_tag(:q, "Search for:")%>
                     <%=text_field_tag(:q)%>
                     <%=check_box_tag "chkbx","1",true %>
                     <%= submit_tag("Search") %>
                
                <%end%>
        
       
       
      produce il seguente snipept HTML: 
       
               <form accept-charset="UTF-8" 
                     action="/pages/demo_form_2/search" 
                     method="get">
             
              <div style="margin:0;padding:0;display:inline">
                  
                  <input name="utf8" type="hidden" value="&#x2713;"/>
                  <input name="authenticity_token" 
                         type="hidden" 
                         value="aXMLwQKFyGcAR6hIsUvYbPhvHfyL+5STu1kvI9Q6Szc=" />
               </div>
               
               <label for="q">Search for:</label>
               <input id="q" name="q" type="text" />
               <input name="commit" type="submit" value="Search" />
               <input checked="checked" id="chkbx" name="chkbx" type="checkbox" value="1" />
         
         </form>       

        Quindi quando devi costruire la form pezzo per pezzo ed hai bisogno del controllo sull'azione e su
        ogni campo scegli form_tag e i sui var XXX_tag come ad esempio label_tag, text_field_tag() e così via..     

        OSSERVAZIONE: PASSAGGIO DEI PARAMETRI IN UNA QUERY STRING TRAMITE GLI HELPER GENERATI DAL COMPONENTE DI
                      ROUTING
                      
        In routes.rb ho ad esempio generato l'helper search(): 
        
          get "pages/demo_form_2/search",:to =>"pages#search",:as=>"search" 
        
        Posso passargli dei parametri alla query string: 
        
          search_path(:variabile=>"Wibble111") si veda ad esempio:  demo_form_2.html.erb 
        
        e verrà aggiunta la seguente query string : 
        
          ?variabile=Wibble111"
       
       In questo caso però essendo in action="" di una form con metodo GET, viene tagliata dal componente di routing 
       non essendo prevista nel routing. Se invece la utilizziamo in un normale link generato ad esempio con link_to()
       allora verrà passata ed utilizzata normalmente. 
       
       
       
       
       OSSERVAZIONE: PASSAGGIO DI ARRAY AD UN QUALSIASI HELPER. (form_tag(), form_for(), link_to() & company )
       
       Tutti gli helper di Rails, possono ricevere array come parametri. In questo caso i veri elementi di un array 
       vengono utilizzati per generare gli URLs. Ad esempio passando [:adin,@user] a form_tag() questo helper 
       come gli altri, utilizzerà gli elementi dentro l'array per generare gli elementi dell'URL, ad esempio in questo 
       caso:
       
          action="/admin/users/5"       
      
      
                          
=end

def demo_form_2 
      @user = User.first
      @title = "Demo form 2 - "
  
end   


def search 
     
     @title = "Demo form 2 - search form response for demo form 2 - "

end



=begin

         Vediamo adesso che il componente di routing di rails si comporta in maniera intelligente
         riguardo i valori che gli arrivano. Possiamo dire che è smarty durante la creazione della 
         variabile globale params, sostanzialmente un HashWithIndifferentAccess. 
         
         Se a tale componente arriva ad esempio nella query string il valore di una variabile come
         ad esempio "ticket[title]=valore_passato" allora subito genera un Hash chiamato ticket: 
         
         ticket=>{title=>"valore_passato"} 
         
         Facciamo un esempio. Il seguente snippet di codice : 
         
          <%= form_tag search_path, :method=>:get do %>
                  <div>
                    <%=label_tag("ticket[title]","Ticket title:")%>
                  </div>
                  
                  <div>
                    <%=text_field_tag("ticket[title]")%>
                  </div> 
                 
                   <div>
                    <%=label_tag("ticket[description]","Ticket description:")%>
                  </div>
                  
                  <div>
                    <%=text_field_tag("ticket[description]")%>
                  </div> 
                 
                   <%= submit_tag("Search") %>
           
           <%end%>
         
         
         Produrrà il seguente snippet di HTML : 
         
          <form accept-charset="UTF-8" action="/pages/demo_form_2/search?variabile=Wibble111" method="get"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /></div>
                  <div>
                    <label for="ticket_title">Ticket title:</label>
                  </div>
                  
                  <div>
                    <input id="ticket_title" name="ticket[title]" type="text" />
                  </div> 
                 
                   <div>

                    <label for="ticket_description">Ticket description:</label>
                  </div>
                  
                  <div>
                    <input id="ticket_description" name="ticket[description]" type="text" />
                  </div> 
                 
         
         e il componente di routing di Rails genererà : 
         
         ticket => {"title"        => "valore inserito campo",
                    "description"  => "valore inserito nel campo"  
                    }
         
         
          
=end



def demo_form_3 
  
  @title = "Demo form 3 - smarty parameters - "
  
  
end

=begin
       OSSERVAZIONE: LA GENERAZIONE DI FORM AD-HOC È UTILE QUANDO NON DOBBIAMO CREARE/FARE UPDATE, DI UNA SOLA RISORSA 
                     DEL MODEL COME Ticket oppure Project, MA QUANDO LA RAPPRESENTAZIONE DELLA RISORSA, O MEGLIO LA 
                     RAPPRESENTAZIONE DELLA CREAZIONE O DELLA MODIFICA DELLA RISORSA RICHIESTA È PIÙ COMPLESSA 
                     E COINVOLGE AD ESEMPIO DIVERSE RISORSE. 
                     
                     Facciamo un esempio ispirato al modello del dominio di ticketee. In particolare sull'azione di 
                     modifica dei permessi. Si desidera che l'utente amministratore abbia la facoltà di poter cambiare
                     a suo piacimento, i permessi che un determinato utente possiede su di un determinato progetto.
                     
                     È presenta una link table, che però non rappresenta in effetti un'associaizone many to many, o
                     meglio potrebbe essere utilizzata anche per questo scopo, ma non è qui per quello. Questa link 
                     table ci serve per stabilire quali utenti possono eseguire quali azioni su quali risorse. 
                     
                     Sostanzialmente è presente un'associazione one<->to<->many tra User e Permission che è la classe del
                     model della link-table, e un'associazione polimorfica one<->to<->many tra risorse polimorfiche come 
                     Ticket, oppure Project sempre con permission. 
=end


  def demo_form_4
          
          @title="Demo form 4 -" 
          user = User.includes(:permissions=>:thing).find(1) 
          
          projects = Project.all
          
          @permissions={}
         
          projects.each do |project|
                
                @permissions[project.name]={}
                
                user.permissions.each do |permission|
                     
                    if permission.thing == project 
                        if permission.action=="view"
                              @permissions[permission.thing.name]["view"]=true
                        else
                             @permissions[permission.thing.name]["view"]=false
                        end 
                   end 
                    
                    if permission.thing == project 
                        if permission.action=="create tickets"
                               @permissions[permission.thing.name]["create tickets"]=true
                        else
                               @permissions[permission.thing.name]["create tickets"]=false
                        end                          
                    end
               end     
               
               if @permissions[project.name].empty? 
                    @permissions[project.name]={"view"=>false,"create tickets"=>false}
               end 
         end
         
=begin
       Queste linee producono: 
       
   SELECT "users".* FROM "users" WHERE "users"."id" = $1 LIMIT 1  [["id", 1]]
   SELECT "permissions".* FROM "permissions" WHERE "permissions"."user_id" IN (1)
   SELECT "projects".* FROM "projects" WHERE "projects"."id" IN (1, 3)
   SELECT "projects".* FROM "projects" 
   
  # ==> Per cosa è ??  SELECT "users".* FROM "users" WHERE "users"."id" = 1 LIMIT 1 
  
  # ==> La tabella permission:  
  
  id | user_id | thing_id | thing_type | action | created_at | updated_at 
 ----+---------+----------+------------+--------+------------+------------            
  
 
=end
 
end

  
  def permissions_update
    @title="Demo form 5 - response -"
    p params[:permission]
    
  end 


end 




