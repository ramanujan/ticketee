=begin
      La tabella relativa a permission è la seguente:
       
     id | user_id | thing_id | thing_type | action | created_at | updated_at 
    ----+---------+----------+------------+--------+------------+------------
    
     Come si vede, possiamo vederla come una MODEL-ASSOCIATION-TABLE. Infatti ci sono due colonne user_id, thing_id, una che contiene una foreign key
     verso la tabella users, l'altra che contiene una foreign_key in associazione polimorfica verso una tabella che può essere tickets, projects e 
     così via.. 
     
     Come sappiamo questo implica un'associazione MANY-TO-MANY tra la classe User e la classe associata polimorficamente, come ad esempio la classe
     (Project). Questo ha senso nell'applicazione, in quanto ad una certa istanza di Project, possono essere associate una o più istanze di User,
     e dall'altra parte ad una certa istanza di User possono essere associate una o più istanza di Project. Dall'altra parte anche altri oggetti
     di questa applicazione possono presentare questa caratteristica e questo giustifica l'associazione polimorfica. 
     
     Ma cosa è brevemente un'associazione polimorfica? Qui si parla di associazioni polimorfiche nel senso particolare attribuito da ActiveRecord 
     a questo termine e non nel senso comune alle altre soluzioni ORM, e cioè quello di una classe che è associata ad una superclasse e quindi
     polimorficamente alle relative sottoclassi della superclasse, ma nel senso dell'utilizzo dell'opzione :polymorphic.  
     
     L'opzione :polymorphic la possiamo utilizzare con le macro has_one(), belongs_to(), has_many(). Con questa opzione possiamo specificare che 
     un certo oggetto è associato ad un'altro oggetto in maniera polimorfica, il che significa semplicemente che il tipo dell'oggetto
     associato è registrato nel database insieme con la foreign key. Questo è possibile perchè dal punto di vista di ActiveRecord, una <<FK>> non
     è altro che una colonna INTEGER. Ovviamente questo tipo di associazione non sarà possibile in database come MySql+Innodb dove vengonno controllati
     miniziosamente i vincoli d'integrità relazionale. 
      
          
     Rendendo l'associazione belongs_to() oppure has_one() polimorfica, astraiamo l'associazione in modo che ogni oggetto 
     del model nel sistema che stiamo sviluppando, possa riempirla. In altri termini non ci riferiamo ad un oggetto di una classe ben precisa, e quindi,
     ad una tabella ben precisa. 
     
      In questo esempio andiamo a costruire una classe Comment. Essenzialmente andiamo a dire che Comment può appartenere (many->to->one ) a diverse
      classi del MODEL tramite l'associazione polimorfica subject.
          
             class Comment < ActiveRecord::Base
                belongs_to :subject, :polimorphic=>true
             end
      
      Nel nostro specifico esempio della classe del model Permission, dovremmo impostare due associazione many->to->one, una con
      la classe del MODEL User e l'altra in maniera polimorfica. Si noti che se ActiveRecord non supportasse le associzioni
      polimorfiche, dovremmo stabile un'associazione belongs_to many->to->one per ogni classe del MODEL desiderata. 
      Quindi:
      
      class Permission < ActiveRecord::Base
         belongs_to :user
         belongs_to :thing, :polymorphic=>true
      end

    A questo punto, ActiveRecord sa che questo tipo di associazione e cioè l'associazione many->to->one chiamata thing è 
    polimorfica. Quando assegnamo un oggetto con quest'associazione,ad esempio un'istanza di Project, project, ActiveRecord
    gestisce l'associazione e fa due cose:
    
    permission.thing_id = project.id
    permission.thing_type = project.class.to_s 
        
      
=end

class Permission < ActiveRecord::Base

   belongs_to :user
   belongs_to :thing, :polymorphic=>true
end
