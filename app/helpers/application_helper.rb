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
  

end
