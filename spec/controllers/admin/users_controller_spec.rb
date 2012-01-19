=begin
      Qui sotto utilizziamo un blocco before(). Questo blocco viene eseguito prima di ogni esempio
      ovvero prima di ogni test, cioè dell'esecuzione di ogni blocco do .. end dentro it, piazzati
      nel  blocco corrente context oppure describe.
      
      Inizialmente alla stesura della specifica, abbiamo utilizzato:
       
       let(:user) do
       
          user = Factory(:user)
          user.confirm!
          user
       
       end
       
       Che è un blocco di codice tale e quale a quello utilizzato nella spec per il controller
       projects. Allora l'idea è di essere DRY e di piazzare questo pezzo di codice dentro un modulo
       che ha il compito di fornire metodi che hanno a che fare con il seeding dei dati. Questo
       modulo si trova in seed_helpers ed è chiamato ovviamente SeedHelpers 
       
       Ricordiamo che quello di muovere gli helpers dentro dei moduli nella directory support, per Rspec 
       è un best practice. 
       
       
=end


require 'spec_helper'

describe Admin::UsersController do

  context "standard users" do
      let(:user) do
        create_user! 
      end
      
      before do
         sign_in(:user,user)
      end
      
      it "are not able to access the index action" do
        get :index
        response.should redirect_to(root_path)
        flash[:alert].should eql("You must be an admin to do that.")
      end      
      
  end 

end
