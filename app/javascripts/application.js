//= require <jquery-1.4.2.min>

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


var radiator = {

  animateFails: function() {
    $(".radiator .project-fail").each(function() {
      var el = $(this);
      var toOrange = function() {
        el.animate({backgroundColor: '#ffaa00'}, 1000, 'swing', toRed);  
      }
      var toRed = function() {
        el.animate({backgroundColor: '#ff0000'}, 1000, 'swing', toOrange);  
      }
      toOrange();
   });       
  },
  
  updatePeriodically: function() {
    $("#radiator-content").each(function() {
      var outer = $(this);
      setInterval(function() {
        $.ajax({
          method: 'get',
          url: '/radiator',
          success: function(replacement) {
            $(".radiator .project-fail").stop();
            outer.html(replacement);
            radiator.animateFails();
          }
        });
      }, 30000);   
    });
  }

};
