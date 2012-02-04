=begin
      
      Si noti che in index.html.erb relativa all'azione index ivi presente si 
      esegue la resa di una forma, eseguita con form_tag():
      
       <%=form_tag update_user_permissions_path, :method=>:put do %>
       
       <%end%>
  
      Questo helper di rails, ci serve per costruire delle forms GENERICHE invece
      che orientate ad una classe del model. In particolare produce il seguente 
      frammento HTML :
      
      <form accept-charset="UTF-8" action="/admin/users/5/permissions" 
                                   method="post">
        
        
        <div style="margin:0;padding:0;display:inline">
                 <input name="utf8" type="hidden" value="&#x2713;" />
                 <input name="_method" type="hidden" value="put" />
                 <input name="authenticity_token" type="hidden" value="AYV+V87Lfm6dDr2spJSLiJ7Psqy96WWuMuEUMD+otj8=" />
        </div>

     
     </form>
      
    Si noti che l'URL di action, lo abbiamo generato per mezzo di un helper generato automaticamente da routes per mezzo della seguente
    linea in routes.rb :
    
     put 'admin/users/:user_id/permissions', 
       :to => 'admin#permissions#update',
       :as => :update_user_permissions
    
    
    Tutti questi giri li stiamo facendo perchè adesso non dobbiamo eseguire una normale operazione UPDATE di REST, che coinvogerebbe
    un solo record nella tabella permissios. Qui la form presentata all'utente deve essere personalizzata. Infatti vogliamo presentare
    una lista di tutti i progetti presenti, con a fianco tante checkbox quante ce ne serviranno per impostare permessi relativi all'utente
    sui progetti. Orbene al'interno di: 
    
       <%=form_tag update_user_permissions_path, :method=>:put do %>
       
       <%end%>  
    
    Andremo a piazzare : 
    
      <%permissions.each do |name,value|%>
                                      <td>
                                              
                                             <%=check_box_tag "permissions[#{project.id}][#{name}]","1"
                                                              @ability.can?(name.to_sym,project)  
                                             %> 
                                    
                                      </td>           
       

  Si sta utilizzando quindi l'helper check_box_tag(). Questo tag si usa in questi casi, quando cioè si stanno costruendo delle generiche 
  forms. Produrrà :
    
               <td>
                                              
                  <!--Il primo parametro imposta name,id. Il secondo parametro il value quando checked. -->
                                              
                   <input id="permissions_1_view" name="permissions[1][view]" type="checkbox" value="1" /> 
                                    
               </td>  
  
  
               <td>
                                              
                  <!--Il primo parametro imposta name,id. Il secondo parametro il value quando checked. -->
                                              
                   <input id="permissions_2_view" name="permissions[2][view]" type="checkbox" value="1" /> 
                                    
              </td> 
    
               
               Ricordiamo che il componente di Rails Rack (che tra le altre cose va a generare params) riceve 
               la stringa HTTP "...?permission[1][view]=1&permission[2][view]=1... l'ananlizza e crea subito un hash 
               with indifferent access, 
                
                permission={ 
                           
                           "1"=>{"view"=>"1"}
                           
                           "2"=>{"view"=>"1"}
                           ..
                           
                           }
               
               Si ricorda che se la checkbox X non è settata, allora non verrà spedita la relativa permission[X][view]=1, questo
               significa che non coparirà nell'Hash la relativa entry. 

=end




class Admin::PermissionsController < Admin::BaseController
   
     
     before_filter :find_user 
     
     
     def find_user 
       
       
        @user = User.find(params[:user_id]) 
        rescue ActiveRecord::RecordNotFound
         flash[:alert] = "The user you were looking for could not be found."
         redirect_to _admin_users_path 
       
     end
     
     
     private :find_user 
     
 
=begin
         permission={ 
                           
                           "1"=>{"view"=>"1"}
                           
                           "2"=>{"view"=>"1"}
                           ..
                           
                           } 
=end 
     
     
     def index
      
         @title="Setting up permissions for #{@user} - "
         
         @projects = Project.all 
         
         @ability = Ability.new(@user) 
               
     end


     
     
     
     
     
     
     
     
     def update 

=begin
       @user.permission.delete_all se non specifichiamo alcuna dipendenza tra le classi del moeìdel, 
       nullifica user_id nella tabella di link.  
       
         
=end       
           @user.permissions.delete_all
       
         
     begin
        
        unless( params[:permissions].nil? )
         
           params[:permissions].each do |project_id, permissions|
            
                     project = Project.find(project_id) # N.B. Sembra che non sia necessaria una conversione da stringa a numero.   
               
                     permissions.each do |permission,checked| 

                            @user.permissions.create! :thing=>project, :action=>permission 
                     end                
           
           end    
          
           
        end        
     
     flash[:notice]="Permissions updated."
     redirect_to admin_user_permissions_path(@user)
        
   rescue => msg
     
   
     flash[:error]="Permissions not updated : #{msg}"
     redirect_to admin_user_permissions_path(@user)
     
     end          
     
    
           
           
   end
           
            
      



end
