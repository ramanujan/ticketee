=begin
         'spec_helper.rb'   viene caricato da /spec. Ha il compito di caricare l'ambiente per i test. 
          Ha già il codice necessario per includere l'ambiente Rails e anche gli helper associati a Rails. 
          Inoltre carica tutto in rspec/support e nelle sue sottodirectory. 
          
          describe : ci serve a descrivere un componente, in questo caso la classe ProjectsController.
                     Racchiude un insieme di tests, detti esempi che ci servono a testare un comportamento
                     del modulo.       
          get  : Dice a RSpec di eseguire l'azione show(), ovvero di eseguire una GET request all'azione show
                 del controller ProjectsController      
                 L'oggetto response modella la risposta a questa get, e testiamo che sia una redirect 
                 verso /projects 
=end

require 'spec_helper'

describe ProjectsController do
       
       it "displays an error for a missing project" do
         get :show, :id=>"not-here"
         response.should redirect_to(projects_path)
         message="The project you were looking for could not be found."
         flash[:alert].should eql(message) 
       end
       
       
end
