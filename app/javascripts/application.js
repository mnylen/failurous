//= require <jquery-1.4.2.min>
//= require <jquery-ui-1.8.5.custom.min>

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
    
    $(".show-occurence").click(function() {
      var container = $(this).parent().eq(0).parent().eq(0).children('.container');
      if (container.hasClass('open')) {
        container.hide();
        container.removeClass('open');
        container.addClass('hidden');
      } else {
        container.removeClass('hidden');
        container.addClass('open');
        container.load($(this).attr('href'));
        container.show();
      }
      
      return false;
    });
    
    $(".slogan").click(function() {
      changeSlogan($(this));
    });

    setInterval(function() {
      changeSlogan($(".slogan"));
    }, 10000);
    
    $(".instruction-tabs").tabs();
});

function changeSlogan(elem) {
  var new_slogan = "";
  $.ajax({
    method: 'get',
    url: '/random_slogan',
    success: function(slogan) {
      new_slogan = slogan;
    }
  });  
  elem.parent().fadeOut('slow', function() {
    elem.html(new_slogan)
    elem.parent().fadeIn('slow');
  });
}

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

