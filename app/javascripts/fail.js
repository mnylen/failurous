var fail = function() {
  var loadOccurence = function(oldData, link) {
    $.get(link.attr('href'), function(data) {
      var newData = $(data);
      $(oldData).replaceWith(newData);
      newData.show();

      fail.loadOccurencesUsingFailControls();
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
        var data = $(v).children('.data');
       
        $(fail).children().find('.occurence-link').each(function(i, link) {
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
