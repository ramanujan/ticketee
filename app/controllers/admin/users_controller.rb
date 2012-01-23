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
          
          
      Si noti che in questa sede, abbiamo cambiato Admin::UsercController < ApplicationController con 
      
        Admin::UserController < BaseController 
        
      Poichè desideriamo invocare authorize_admin! per tutti i controllori dentro questo namespace, quello che abbiamo fatto è 
      stato di costruire una sorta di super controller, BaseController,che ah il compito di invocare:
      
       before_filter :authorize_admin!
      
      Gli altri controllori in questo namespace ereditano da BaseController. Si noti che ogni 
      filtro eseguito nella superclasse è come se venisse invocato dalle sue sottoclassi e quindi
      anche in Admin::UsersController. 
      
      Si noti che saranno ereditati anche le azioni e quindi le views, che eventualmente dovremo
      sovrascrivere. 
      
           
          
=end

class Admin::UsersController < Admin::BaseController
  before_filter :authorize_admin! # Metodo definito in application_controller.rb
  
  before_filter :find_user,:only=>[:show]
  
  def find_user 
       
       begin
       
             @user = User.find(params[:id])
       
       rescue ActiveRecord::RecordNotFound
        
         flash[:alert] = "The user you were looking for could not be found." 
         redirect_to admin_users_path  
               
       end
       
  end
  
  private :find_user 
  
  
  def index

=begin
       Si noti che al posto della riga qui sotto, potremmo utilizzare allo stesso modo:
       User.order(:email).all
=end

    
       
       @users = User.all(:order=>:email)  # Si noti come è stato specificato l'ordinamento. 
       
       #@users= User.order(:email).all
       
       @title="All users - "
  end
  
  def new
        @user = User.new 
        @title="Creating new user - "
  end


=begin
        Si noti che dalla checkbox arriva {...:admin=>'1'} se è checkata altrimenti {...:admin=>'0'} 
=end
  
  def create
    
        @user = User.new params[:user]  
        
        @user.admin = (params[:user][:admin] == '1')
        
        if @user.save 
            flash[:notice]="User has been created."
            redirect_to [:admin,@user]
        else
            flash[:error]="User has not been created."
            @title="User creation errors - "
            render 'new'          
        end
  end

  
  def show

     @title="Showing user #{@user}" #Ricordiamo che in questo caso viene onvocato @user.to_s, che ho sovrascritto. 
         
  end 



end
