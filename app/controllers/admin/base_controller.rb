class Admin::BaseController < ApplicationController
  
  before_filter :authorize_admin! # Metodo definito in application_controller.rb
  
    def index 
      
      @title="Administration page - "
    
    end
  
end


