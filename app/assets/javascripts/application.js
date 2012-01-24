// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

/*
 * La funzione $() oppure la funzione jQuery() ritornano un oggetto JavaScript contenente un ARRAY DI ELEMENTI DEL DOM. 
 * Viene mantenuto l'ordine di definizione nel documento. 
 * 
 * Questo oggetto incredibile, ha un gran numero di metodi definiti, che sono studiati per agire sulla collezione di
 * oggetti del DOM ricavato. 
 * 
 * Questo oggetto speciale è detto WRAPPER. 
 * 
 * Ad esempio, diciamo di voler recuperare tutti i <div> della pagina che hanno la classe="notLongForThisWorld"
 * 
 * 
 */

$(document).ready(function() {
  $("div.notLongForThisWorld").hide().addClass("removed");
  $("div.removed").show(); 
  
  $("div.removed")[0].innerHTML="I have added some text"; //Solo il primo elemento.
  
  for(i=1; i<$("div.removed").length; i++ ){
  	$("div.removed")[i].innerHTML="I have added some text to a group node"
  }
  
  // $("div.removed").html("I have added some text to a group node"); <=== Ha effetto su tutti. 
 
 
 /* Un piccolo assaggio dei selettori presenti:
 
  $("p:even") Selects all even <p> elements
  
  $("tr:nth-child(1)") Selects the first row of each table
  
  $("body > div") Selects direct <div> children of <body>
  
  $("a[href$= 'pdf ']") Selects links to PDF files
  
  $("body > div:has(a)") Selects direct <div> children of <body>-containing links

 */
 
  
  /*  ---Selector and Context---
   *  
   * Il metodo $() riceve in generale due parametri, un selettore ed un contesto. Se non specifichiamo alcun
   * contesto, viene allora preso come contesto ogni elemento del dom tree. Se invece spacifichiamo un contesto
   * come ad esempio:   
   *   
   *    $("div p","div#sampleDOM")
   * 
   * stiamo chiedendo di selezionare tutti gli elementi <p> dentro <div> che però rientrino al'interno di un <div> 
   * che abbia id="sampleDOM"
   * 
   * 
   * 
   * 
   * 
   */
 
 
 
 
 });

$("<p>Hi Figlio di puttanz</p>")

