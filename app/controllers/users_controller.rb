class UsersController < ApplicationController
    
    def confirmation
         @title="Sign up successfull - "
         @resource=User.find(params[:id])
         render "devise/mailer/confirmation_instructions"      
    end

end
