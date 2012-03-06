class Api::V1::BaseController < ActionController::Base
  
  respond_to    :json, :xml
  before_filter :authenticate_user
  
  private 
  
  def authenticate_user 
  
    @current_user = User.find_by_authentication_token(params[:token])     
    
    unless @current_user # Entra se false oppure nil
      respond_with({:error=>"Token is invalid."})  
    end
  
  end 
  
  def current_user 
    @current_user
  end
  
end

# Si noti che inserire qui respond_to :json, prepara tutti i controllori che ereditano da questo 
# a rispondere ad una richiesta di una rappresentazione JSON. 
# Ad esempio il primo controllore che abbiamo creato, che risponde ad una richiesta di rappresentazione
# JSON è ProjectsController (dentro il namespace Api::V1 ovviamente)

