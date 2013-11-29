(function() {
  var $, delay;

  delay = function(ms, func) {
    return setTimeout(func, ms);
  };

  $ = jQuery;

  $.extend($.easing, {
    avOutExpo: function(x, t, b, c, d) {
      if (t === d) {
        return b + c;
      } else {
        return c * (-Math.pow(2, -10 * t / d) + 1) + b;
      }
    },
    avInExpo: function(x, t, b, c, d) {
      if (t === 0) {
        return b;
      } else {
        return c * Math.pow(2, 10 * (t / d - 1)) + b;
      }
    }
  });

  $.extend($, {
    av: {
      version: '1.0.1',
      width: 250,
      height: 88,
      prefix: 'alert_view_',
      increment_id: 0,
      queue: [],
      pop: function(arg) {
        var aid, box, top;
        if (arg == null) {
          arg = {};
        }
        /*
        pop alert view.
        */

        if (arg.expire == null) {
          arg.expire = 5000;
        }
        if (arg.title == null) {
          arg.title = '';
        }
        if (arg.message == null) {
          arg.message = '';
        }
        if (arg.template == null) {
          arg.template = 'default';
        }
        if (arg.mode == null) {
          arg.mode = 'notification';
        }
        aid = this.prefix + ++this.increment_id;
        if (arg.mode === 'alert') {
          box = $("<div id='" + aid + "' class='alert_view'>\n    <span class='av_title'>" + arg.title + "</span>\n    <span class='av_message'>" + arg.message + "</span>\n    <div class='av_close' onclick=\"$.av.hide('" + aid + "');\">X</div>\n</div>");
          box.css({
            width: $('.alert_view_center').width()
          });
          if ($('.alert_view_center').find('.alert_view').length === 0) {
            box.css({
              opacity: 0.0,
              'margin-top': '-25px'
            });
          }
          $('.alert_view_center').html(box);
          $("#" + aid).animate({
            opacity: 0.9,
            'margin-top': '0'
          }, 400, 'avOutExpo', arg.expire > 0 ? delay(arg.expire, function() {
            return $.av.hide(aid);
          }) : void 0);
        } else {
          box = $("<div id='" + aid + "' class='alert_view alert_view_notification'>\n  <div class='av_title'>" + arg.title + "</div>\n  <div class='av_message'>" + arg.message + "</div>\n</div>");
          top = this.queue.length * this.height;
          this.queue.push(aid);
          $('body').append(box);
          $("#" + aid).css({
            right: -this.width,
            top: top
          });
          $("#" + aid).animate({
            right: 0
          }, 400, 'avOutExpo', arg.expire > 0 ? delay(arg.expire, function() {
            return $.av.hide(aid);
          }) : void 0);
        }
        switch (arg.template) {
          case 'error':
            box.addClass('alert_view_error');
            break;
          case 'black':
            box.addClass('alert_view_black');
        }
        return aid;
      },
      hide: function(aid) {
        /*
        hide alert view.
        */

        if ($("#" + aid).hasClass('alert_view_notification')) {
          $("#" + aid).animate({
            right: -this.width,
            opacity: 0
          }, 400, 'avInExpo', function() {
            var $box, id, remove_top, top, _i, _len, _ref, _results;
            remove_top = parseInt($(this).css('top'));
            $.av.queue = $.av.queue.filter(function(x) {
              return x !== aid;
            });
            $(this).remove();
            _ref = $.av.queue;
            _results = [];
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              id = _ref[_i];
              $box = $("#" + id);
              top = parseInt($box.attr('new_top') ? $box.attr('new_top') : $box.css('top'));
              if (top >= remove_top) {
                top -= $.av.height;
                $box.attr({
                  new_top: top
                });
                $box.dequeue();
                _results.push($box.animate({
                  top: top
                }, 400, 'avOutExpo'));
              } else {
                _results.push(void 0);
              }
            }
            return _results;
          });
        } else {
          $("#" + aid).animate({
            opacity: 0.0
          }, 400, function() {
            return $(this).remove();
          });
        }
      }
    }
  });

}).call(this);
