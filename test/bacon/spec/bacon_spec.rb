=begin
       
       ---
       
       RSpec è un'implementazione di BDD testing suite. I test RSpec sono scritti con un linguaggio 
       DSL. Il beneficio è che il cliente può capire cosa il test sta testando, e che si possono utilizzare
       gli steps come ACCEPTANCE TESTING. 
       
        1) Uno sviluppatore può leggere cosa dovrebbe fare la feature e potrà scrivere il codice. 
        2) Un cliente può capire cosa fa un certo requisito richiesto (feature)
        3) Si viene a creare una suite automatizzata di test che possiamo lanciare in qualsiasi momento.
       
       Invece per quanto riguardo l'altro strumento di testing Cucumber esso utilizza un linguaggio
       noto come GHERKIN. Esso è simile a 
       
        Given I am reading abook
        
        When I read this example
        
        Then I should learn something
       
       Ogni linea indica uno STEP. 
        
       Sostanzialmente utilizzeremo cucumber per i test dipo INTEGRATION, dove vogliamo testare
       l'attivazione di un itero caso d'uso ovvero di un requisito o feature dell'applicativo.
       Si noti che quando utilizzato con Rails, questo significa far interfacciare cucumber con
       capybara.  
       
       Utilizzeremo invece RSpec per eseguire test BDD su componenti specifici, come ad esempio
       una certa classe. 
       
       ---RSpec---
         
=end


=begin
        Di seguito vogliamo testare il componente Bacon. Per testare questo componente lo dobbiamo
        descrivere con describe(). describe() ci serve sostanzialmente a racchiudere in un involucro
        una serie di test (chiamati esempi) che descrivono insieme il comportamento del componente. 
        
        Si noti che in output avrai Bacon (argomento di describe) is edible? (argomento di it)
        Si noti che il componente da testare può essere messo in un file bacon.rb dentro una directory
        lib. 
        
        
        
=end

require 'bacon'

describe Bacon do
  
  it "is edible?" do
    Bacon.edible?.should be_true
  end
  
end


=begin
         
=end
