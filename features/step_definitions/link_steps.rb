=begin
         Nel seguente step, utilizzo have_css(). Si tratta di un metodo messo a disposizione da
         Capybara, che controlla che la pagina abbia un certo elemento CSS, in questo caso 
         <a> con il testo specificato dall'opzione :text=>
         
         Se questo controllo fallisce, allora Capybara visualizzerà il messaggio passato
         come secondo argomento. Ricordiamo che inspect() è un metodo di String, che ritorna
         una versione printable della stringa. In particolare una versione limitata dalle ""
         e con i caratteri speciali escaped. 
=end

Then /^I should not see "([^"]*)" link$/ do |text|
   
   page.should_not have_css("a",:text=>text), "Expected to not see #{text.inspect} link, but did"
  
end


Then /^I should see "([^"]*)" link$/ do |text|
  page.should have_css("a",:text=>text), "Expected to see #{text.inspect} link, but did not."
end

Then /^the link "([^"]*)" is disabled$/ do |link_name|
   
   page.should_not have_css("a",:text=>link_name), "Expected to not see #{link_name.inspect} link, but did"
   page.should have_content link_name 

end

