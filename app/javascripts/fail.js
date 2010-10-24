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
      $(".fail > .header").click(function() {
        var fail = $(this).parent().eq(0);
        var data = fail.children('.data');

        if (fail.hasClass('collapsed')) {
          fail.removeClass('collapsed');
          fail.addClass('expanded');
          data.slideDown(1500);
        } else {
          data.slideUp(1500, function() {
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
    }
  }
}();
