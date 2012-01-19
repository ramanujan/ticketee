=begin
      Il  proposito di un namespace in questo caso, è quello di SEPARARE UN CONTROLLER DALL'AREA 
      PRINCIPALE DELL'APPLICAZIONE in modo da assicurare che GLI UTENTI CHE ACCEDONO A CODESTO
      CONTROLLER E A TUTTI I CONTROLLER CREATI IN QUESTO NAMESPACE, ABBIANO IL CAMPO admin IMPOSTATO
      A true.
      
      Per costruire un namespaced controller, abbiamo in effetti eseguito:
      
       rails g controller admin/users 
      
      Utilizzando il separatore / indichiamo a Rails di generare un namespaced controller.       
      
      Attenzione affinchè funzioni il routing verso codesto controller è necessario che 
      si inserisca in routes.rb il seguente:
      
      namespace :admin do
         resources :users
      end

      che produce le seguenti informazioni di routing:
      
             admin_users GET    /admin/users(.:format)                  {:action=>"index", :controller=>"admin/users"}
                         POST   /admin/users(.:format)           {:action=>"create", :controller=>"admin/users"}
          new_admin_user GET    /admin/users/new(.:format)       {:action=>"new", :controller=>"admin/users"}
         edit_admin_user GET    /admin/users/:id/edit(.:format)  {:action=>"edit", :controller=>"admin/users"}
              admin_user GET    /admin/users/:id(.:format)       {:action=>"show", :controller=>"admin/users"}
                         PUT    /admin/users/:id(.:format)       {:action=>"update", :controller=>"admin/users"}
                         DELETE /admin/users/:id(.:format)       {:action=>"destroy", :controller=>"admin/users"}
          
=end

class Admin::UsersController < ApplicationController
  before_filter :authorize_admin! # Metodo definito in application_controller.rb
  
  def index
       
  end

end
