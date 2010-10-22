var fail = function() {
  return {
    toggleExpanded: function() {
      $(".fail > .header").click(function() {
        var fail = $(this).parent().eq(0);
        var data = fail.children('.data');

        if (fail.hasClass('collapsed')) {
          fail.removeClass('collapsed');
          fail.addClass('expanded');
          data.slideDown(1000);
        } else {
          data.slideUp(1000);
          fail.removeClass('expanded');
          fail.addClass('collapsed');
        }
      });
    }
  }
}();
