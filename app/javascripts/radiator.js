//= require <jquery-1.4.2.min>
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

