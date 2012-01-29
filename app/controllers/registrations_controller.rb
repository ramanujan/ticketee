=begin
       Devise::RegistrationsController che viene attivato per gestire la registrazione di un nuovo
       utente, dopo il sign up rispedisce l'utente alla root_page per default. In particolare
       analizzando il codice di questo controller vediamo: 
       
       # The path used after sign up for inactive accounts. You need to overwrite
       # this method in your own RegistrationsController.
         
         def after_inactive_sign_up_path_for(resource)
          root_path
         end

      Pertanto l'idea è di sovrascrivere il controller, e quindi di ridefinire questo metodo in modo
      che dopo la registrazione venga presentata la pagina di avvenuta registrazione. 
  
      Ricordiamo una cosa importante. Utilizzando Devise, noi andiamo a generare dgli URLs per il 
      routing, utilizzando:
      
       devise_for :users
      
      Questo genera: 
      
      ...
      
     cancel_user_registration GET    /users/cancel(.:format)   {:action=>"cancel", :controller=>"devise/registrations"}
     
     user_registration        POST   /users(.:format)          {:action=>"create", :controller=>"devise/registrations"}
     
     new_user_registration    GET    /users/sign_up(.:format)  {:action=>"new", :controller=>"devise/registrations"}
     
     edit_user_registration   GET    /users/edit(.:format)     {:action=>"edit", :controller=>"devise/registrations"}
     
                              PUT    /users(.:format)          {:action=>"update", :controller=>"devise/registrations"}
                              
                              DELETE /users(.:format)          {:action=>"destroy", :controller=>"devise/registrations"}
      
      
    fondamentalmente quello che vogliamo fare adesso è di utilizzare il nostro controller. Allora bisogna avvisar devide in modo che generi
    i percorsi in maniera adeguata. In pratica il libro consiglia di fare:
    
    devise_for :users, :controllers => { :registrations => "registrations" }
    
    L'opzione :controllers dice a Devise che vuoi personalizzare i controllori che utilizza, e con il nuovo Hash, gli diciamo che vogliamo
    personalizzare in particolare il controller registrations con il nostro controllore (customizzato) RegistrationsControllers. (detto registrations)   
     
    Dopo questa linea :
    
    
     cancel_user_registration GET    /users/cancel(.:format)  {:action=>"cancel", :controller=>"registrations"}
 
     user_registration        POST   /users(.:format)         {:action=>"create", :controller=>"registrations"}
 
     new_user_registration    GET    /users/sign_up(.:format) {:action=>"new", :controller=>"registrations"}
 
     edit_user_registration   GET    /users/edit(.:format)    {:action=>"edit", :controller=>"registrations"}
                              PUT    /users(.:format)         {:action=>"update", :controller=>"registrations"}
                              DELETE /users(.:format)         {:action=>"destroy", :controller=>"registrations"} 
    
    
    OSSERVAZIONE: 
    
    Quando abbiamo generato le views utilizzate da Devise, queste sono state generate in app/views/devise. Questa directory condivide lo stesso
    nome della directory interna a Devise, che è poi il posto da dove arrivano le views, e se una view utilizzata da Devise esiste per prima nella 
    nostra applicazione,allora Rails non va a vedere di trovare questa view nell'engine associato (devise). 
    
    ATTENZIONE !!
    
    Poichè abbiamo sovrascritto il controller Devise::RegistrationsController, con il nostro 
    RegistrationsController, dobbiamo copiare le views generate da devise in 
    /app/views/registrations    
       
          
=end

class RegistrationsController < Devise::RegistrationsController
  
  private
  
  def after_inactive_sign_up_path_for(resource)
  
      # resource è l'oggetto User che è stato creato per il signup.
  
     p"===================> #{confirm_user_path(:id=>resource.id)}" #è come confirm_user_path(resource.id), passato come params[:id]
     
      
     confirm_user_path(:id=>resource.id) 
  end




end
