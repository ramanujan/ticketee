module ApplicationHelper

   TITLE="Ticketee"
   
   def title
    @title ? @title+TITLE : TITLE
   end

   def linked_image_tag options
      
      if options.instance_of? Hash
          
          if options.has_key? :image_name
              image_name = options[:image_name]  
          else 
             image_name="default.jpg"     
          end
          
          if options.has_key? :linked_to
             linked_to = options[:linked_to]
          else
              linked_to = root_path
          end
          
      else
         raise "Invalid argument. Parameter must be an Hash."
      end
       
    link_to(image_tag(image_name), linked_to )   
       
  end   
  
=begin
          Il metodo try() evidentemente è inserito da Rails tramite ActiveModel.  
          try() ci permette di invocare uno specificato metodo su di un oggetto che
          può essere anche nil e quindi ci evita di gestire un'eccezione su oggetti
          nil. Se quindi il metodo non esiste, oppure current_user ritorna nil try()
          ritorna nil.
           
=end  
  
  def admins_only(&block)
    block.call if current_user.try(:admin?)
    nil
  end   

  
  def authorized?(action,resource,&block)
    
      block.call if can?(action.to_sym,resource) || current_user.try(:admin?)
      nil
  end



end
