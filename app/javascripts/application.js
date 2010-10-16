//= require <jquery-1.4.2.min>

jQuery(document).ready(function($) {

    $("[data-fade]").each(function() {
       var el = $(this);
       setTimeout(function() {
         el.remove();           
       }, el.attr('data-fade') * 1000);
    });
   
   
   
    $(".radiator .project-fail").each(function() {
      var el = $(this);
      var toOrange = function() {
        el.animate({backgroundColor: '#ffaa00'}, 1000, toRed);  
      }
      var toRed = function() {
        el.animate({backgroundColor: '#ff0000'}, 1000, toOrange);  
      }
      toOrange();
   }); 
});
