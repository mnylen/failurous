var fail = function() {
  var loadOccurence = function(oldOccurenceData, link) {
    $.get(link.attr('href'), function(retrievedOccurenceData) {
      var newData = $(retrievedOccurenceData);
      $(oldOccurenceData).find('.box-content').fadeOut(500, function() {
        $(newData).hide();
        $(oldOccurenceData).replaceWith($(newData));
        $(newData).fadeIn(500);
        
        fail.loadOccurencesUsingFailControls();
      });
    });
  };

  return {
    toggleExpanded: function() {
      $(".fail > .box-header").click(function() {
        var fail = $(this).parent().eq(0);
        var data = fail.children('.box-data');

        if (fail.hasClass('collapsed')) {
          fail.removeClass('collapsed');
          fail.addClass('expanded');
          data.slideDown(400);
        } else {
          data.slideUp(400, function() {
            fail.removeClass('expanded');
            fail.addClass('collapsed');
          });
        }
      });
    },

    loadOccurencesUsingFailControls: function() {
      $(".fail").each(function(i, v) {
        var fail = $(v);
        var data = $(v).children('.box-data');
        
        $(fail).children().find('.occurence-link').each(function(i, link) {
          console.debug(link);
          link = $(link);

          link.click(function() {
            loadOccurence(data, link);
            return false;
          });
        });
      });
    },

    toggleShowResolved: function() {
      $("#toggler").change(function() {
        window.location.href = $("#toggler").attr('action') + "?" + $("#toggler").serialize();
      });
    }
  }
}();
