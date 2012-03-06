#coding: utf-8
=begin
       
       ---RSpec---
       
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
       ___________________________________________________________________________________________
       
        
        
        ---RSpec, Useful Fondamentals--- 
        
        1) Il blocco describe() descrive un insieme. Si tratta sostanzialmente di un gruppo di esempi,
           ovvero di un gruppo di tests, che devono descrivere il comportamento di un oggetto,un module ecc.. 
           Ad esempio in questa sede stiamo descrivendo l'oggetto Bacon posto dentro la directory lib caricata automaticamente. 
           Si noti che al metodo describe() si passa l'istanza da descrivere, ed un blocco di codice. 
           Il metodo describe() ritorna un'istanza di Class:
           
             RSpec::Core::ExampleGroup::Nested_1 
           
           Come si deduce dall'esempio, il metodo describe() ritorna una classe detta Nested_1 che è 
           una sottoclasse di ExampleGroup, che serve a racchiudere un gruppo di esempi per rappresentare
           un oggetto. Si noti che il blocco di codice passato a describe() viene eseguito nel contesto di
           questa classe infatti result-object_id e self.object_id ritornano lo stesso numero. 
        
            "self             : #<Class:0x99e691c>"
            "self.object_id   : 80688270"
            "result : RSpec::Core::ExampleGroup::Nested_1"
            "result.object_id : 80688270"
        
        2) Il blocco it() descrive un esempio, un test che deve risiedere dentro un blocco describe(). 

           "self             : #<RSpec::Core::ExampleGroup::Nested_1:0x8d7b1b4>"
           "self.object_id   : 74176730"

           Come si vede ogni blocco viene eseguito ne contesto di un'istanza della classe generata 
           dal blocco describe. Questo che cosa implica? Implica che ogni metodo helper e cioè ogni 
           metodo definito con def..end in un blocco describe, sarà un metodo invocabile da dentro
           it(). Ogni blocco it genera un'istanza di Nested_1 diversa:
           
           "self             : #<RSpec::Core::ExampleGroup::Nested_1:0x932c874>"
           "self.object_id   : 77161530"  
         
         
       3) Il blocco describe, mi serve a creare un contesto preesistente. Questo può essere creato
          per ogni singola esecuzione di it() e cioè per ogni esempio e test, oppure può essere 
          condivido da ogni test. Fondamentalmente si tratta il più delle volte di creare delle
          variabili d'istanza o locali che desideriamo ritrovare anche nel blocco it(). Per questo
          scopo si utilizzi before(:all) oppure before(:each). 
          
          before(:all)
          
          Con before(:all) il suddetto blocco viene eseguito una volta sola, prima dell'esecuzione del primo esempio. Questo blocco 
          verrà eseguito in un'istanza di un Object e creerà delle variabili d'istanza e delle variabili dentro codesto oggetto, 
          e il reference a queste variabili verrà copiato dentro le istanze di Nested_1 create per i vari it() a seguire. In 
          pratica gli esempi CONDIVIDONO IL MEDESIMO OGGETTO FISICO. 
 
          before(:each)
          
          Con before(:each) il suddetto blocco verrà eseguito diverse volte, tecnicamente puoi pensare
          a tante volte quanti sono gli esempi. In pratica ogni esempio avrà una sua propria copia delle
          istanze create nel blocco.  
          
          
      4) Il blocco let(:method_name) { ... }
         
         Con questo metodo, diciamo di costruire un memoized method che esegua il blocco { .. }. 
         Essendo memoized se lo chiami + volte dentro il medesimo blocco it() eseguirà il blocco
         solo la prima volta e ritornerà un cached value alle altre invocazioni. 
         
      5) Il metodo context() è un sinonimo di describe(). Solitamente describe() verrà utilizzato per descrivre un
         componente software come ad esempio un oggetto, o un modulo, mentre context() per creare o raggruppare 
         degli esempi in un contesto. Nella pratica context() si utilizza dentro describe() creando così dei 
         nested-context.
      
      6) Nested-context==> Quando nel codice piazzi 
         
            describe "outer" do 
                 
                   describe "inner" do
                   
                   end
               
            end 
      
        Il blocco di codice "outer" come detto prima viene eseguito nel contesto della classe
        RSpec::Core::ExampleGroup::Nested_1 mentre il blocco "inner" nel contesto di una 
        SOTTOCLASSE DI Nested_1.
        
        Questo significa che, ogni metodo helper, e ogni before/after block, e ogni modulo
        incluso, dichiarato nel blocco outer, ce lo ritroviamo nel blocco inner. 
          
         
=end



require 'bacon'

class A
    
    def metodo_a
       puts "metoodooo_aaaa"  
    end
end


result=describe Bacon do
  
   p "self             : #{self}"
   p "self.object_id   : #{self.object_id}"
  
   
   it "Has this first example." do
       p "self             : #{self}"
       p "self.object_id   : #{self.object_id}" 
   end 
    
    
   it "Has this second example." do
       p "self             : #{self}"
       p "self.object_id   : #{self.object_id}" 
   end 
   
   def helper
       puts "===>Attivato helper con self==>#{self}"
       @variabile = A.new
       p "@variabile.object_id ==> #{@variabile.object_id}" 
   end
   
   
     
   let(:memoized){ puts "Memoized started"}  
   
   puts "________________________INIZIO BEFORE BLOCK________________________________"
     
   before(:each) do
      
      helper() 
   end
   
   
  it "Has this third example." do
      p @variabile
      p "@variabile.object_id dentro it() third example : #{@variabile.object_id}"
    
  end 

  it "Has this fourth example." do
    p @variabile
    p "@variabile.object_id dentro it() fourth example : #{@variabile.object_id}" 
  end 

puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
   
 it "Has this fifth example" do
   
      u = memoized
      x = memoized 
 end  

  it "Has this sixth example" do
   
      u = memoized
      x = memoized 
 end  

  
 it "Has an example that actually utilizes Bacon" do
   
      Bacon.should be_edible    
       
   
 end
  
p "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"

 res = context "under this context" do
           
          p "Under context self : #{self}"
          p "Under context self.object_id : #{self.object_id}<#{self.class}>"
          
          it "Has this example, inside a context block" do
              helper  
              p "Dentro it very nested memoized=>"
              memoized 
          end
           
          
           
                
       end 

 p res
 p res.class
 p res.superclass
 p res.object_id
 
 p "******************************************************************"

end

p result
p result.class


=begin
         
=end
