//= require <jquery-1.4.2.min>

jQuery(document).ready(function($) {

    $("[data-fade]").each(function() {
       var el = $(this);
       setTimeout(function() {
         el.remove();           
       }, el.attr('data-fade') * 1000);
    });
    
    $("#goto").change(function() {
      window.location.href = $(this).val();
    });
    
   
    radiator.animateFails();
    radiator.updatePeriodically();
    
    $('#ceiling-shatner').each(function() {
       var shatner = $(this);
       setTimeout(function() {
         shatner.animate({top: 0}, 1500);
         setTimeout(function() {
           shatner.animate({top: -400}, 1500);
         }, 20000);
       }, 7000);
    });
    
});


var radiator = {

  animateFails: function() {
    $("#radiator-content .project-fail").each(function() {
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
            $(".project-fail", outer).stop();
            outer.html(replacement);
            radiator.animateFails();
          }
        });
      }, 30000);   
    });
  }

};

