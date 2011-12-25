// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function() {
  $("div.notLongForThisWorld").hide().addClass("removed");
  $("div.removed").show(); 
  $("div.removed")[0].innerHTML="I have added some text";
  $("div.removed").html("I have added some text to a group node");
 
 /* Un piccolo assaggio dei selettori presenti:
 
  $("p:even") Selects all even <p> elements
  
  $("tr:nth-child(1)") Selects the first row of each table
  
  $("body > div") Selects direct <div> children of <body>
  
  $("a[href$= 'pdf ']") Selects links to PDF files
  
  $("body > div:has(a)") Selects direct <div> children of <body>-containing links

 */
 
 
 });
