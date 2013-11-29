(function() {
  $(function() {
    $(document).on('click', 'a.center_msg', function() {
      $.av.pop({
        mode: 'alert',
        title: 'Title',
        message: 'AlertView is an alert division which is a jQuery extension. It is like OS X notification window, or Twitter alert message.'
      });
      return false;
    });
    $(document).on('click', 'a.center_error_msg', function() {
      $.av.pop({
        mode: 'alert',
        template: 'error',
        title: 'Title',
        message: 'AlertView is an alert division which is a jQuery extension. It is like OS X notification window, or Twitter alert message.'
      });
      return false;
    });
    $(document).on('click', 'a.center_black_msg', function() {
      $.av.pop({
        mode: 'alert',
        template: 'black',
        title: 'Title',
        message: 'AlertView is an alert division which is a jQuery extension. It is like OS X notification window, or Twitter alert message.'
      });
      return false;
    });
    $(document).on('click', 'a.right_msg', function() {
      $.av.pop({
        title: 'Title',
        message: 'AlertView is an alert division which is a jQuery extension.'
      });
      return false;
    });
    $(document).on('click', 'a.right_error_msg', function() {
      $.av.pop({
        template: 'error',
        title: 'Error!',
        message: 'AlertView is an alert division which is a jQuery extension.'
      });
      return false;
    });
    return $(document).on('click', 'a.right_black_msg', function() {
      $.av.pop({
        template: 'black',
        title: 'Black',
        message: 'AlertView is an alert division which is a jQuery extension.'
      });
      return false;
    });
  });

}).call(this);
