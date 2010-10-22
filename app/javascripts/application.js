//= require <jquery-1.4.2.min>
//= require <jquery-ui-1.8.5.custom.min>

jQuery(document).ready(function($) {

    $("[data-fade]").each(function() {
       var el = $(this);
       setTimeout(function() {
         el.remove();           
       }, el.attr('data-fade') * 1000);
    });
    
   
    radiator.animateFails();
    radiator.updatePeriodically();
});
