=begin
        Come creare delle applicazioni che siano MANTENIBILI?
        La risposta è che devi creare dei test automatizzati. 
        Scrivere dei test automatizzati, ti assicura requisito dopo requisito,
        che la tua applicazione sta funzionando esattamente come richiesto. 
        
        Test and behavior-driven development
        
        Nel mondo di Ruby un'enfasi speciale viene data per due filosofie di sviluppo :
        
        1) TEST DRIVEN DEVELOPMENT
        2) BEHAVIOUR DRIVEN DEVELOPMENT
        
        In particolare nell'incarnazione di Test::Unit, RSpec e Cucumber.
        
        TDD è una metodologia di sviluppo, che consiste nello scrivere per prima cosa un test
        che ovviamente fallirà (RED) poi scrivere il codice affinchè il test passi (GREEN) e
        quindi eseguire il refactoring per eliminare le ridondanze e rendere il codice DRY.
        
        TDD e BDD ti danno il tempo di pensare alle decisioni da prendere, prima che venga scritto
        del codice. 
=end

require 'test/unit'

class ExampleTest < Test::Unit::TestCase
  
  def test_truth
   assert  true
  end

end

=begin
       La libreria standard di Ruby ha unit.rb. Questo file fornisce la classe Test::Unit::TestCase
       che quindi fa parte della libreria standard di Ruby. QUANDO UNA CLASSE EREDITA DA TestCase
       E NOI ESEGUIAMO ruby example_test.rb ALLORA VERRANNO ESEGUITI TUTTI I METODI CHE COMINCIANO CON
       'test' 
       
       Il metodo assert() esegue controlla se l'argomento passato è true oppure false. Se true allora
       il test passa, se false allora il test fallisce. 
       
       Ma come usarlo realmente? In altri termini come utilizzarlo per testare realmente il funzionamento
       di un certo componente?
       
       Supponiamo di seguito che si desideri testare una classe denominata Bacon:        
=end

class BaconTest < Test::Unit::TestCase
  
    def test_saved
      assert Bacon.saved?, "The method Bacon.saved?() returned false, but was expected true!"
    end
  
end

class Bacon 
  def self.saved?
    true 
  end
end

