=begin
   
    Get,Post, Put, Delete, Anithing
    
    Possiamo definire routes che rispondono solo ai verbi HTTP GET,POST,PUT,DELETE con gli omonimi metodi 
    di Rails get,post,put,delete. Tutti questi metodi utilizzano la stessa sintassi, e lavorano in maniera
    molto simile, me definiscono routes che rispondono solo a determinati verbi. Se non importa a quali verbi
    dobbiamo rispondere e cioè rispondiamo con la stessa azione a tutti i verbi, dobbiamo utilizzare il 
    match(). 
    
     match "some/route", :to=>"some#controller_action"
    
    Questo route risponde a tutti i verbi: GET,POST,PUT,DELETE . Se desideriamo, possiamo utilizzare match() in maniera 
    equivalente a post(), put(), get() e delete():doc:
    
     match "some/route", :to=>"some#controller_action", :conditions=>{:method=>:get}    
       
    Ricordiamo poi che ad esempio queste linee equivalgono:
    
    get "pages/jquery" <===> get 'pages/jquery, :to=>"pages#jquery",:as=>"pages_jquery" 
     
    get "pages/jquery" <===> get 'pages/jquery, => "pages#jquery" 
    
    get "pages/jquery" <===> match "pages/jquery", :to=>"pages#jquery", :conditions=>{:method=>:get}
    
    
      
       
=end

Ticketee::Application.routes.draw do
  
   get "pages/jquery" => "pages#demo_jquery"
   
   get "pages/home" 
   
   get "payments/index"

   get "payments/confirm"

   get "payments/complete"

   get "payments/checkout"
    
   devise_for :users, :controllers=>{:registrations=>'registrations'} #vedi registrations_controller.rb 
    
   get 'awaiting_confirmation',:to=>"users#confirmation",:as=>"confirm_user" # Utilizzato in RegistrationController#after.. (confirm_user_path)
   
   
   
  
   root :to => 'projects#index'
 
  resources :projects do
    resources :tickets
    end

   namespace :admin do
         root :to=>"base#index" # Si riferisce a Admin::BaseController.index 
         resources :users
      end 



  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
