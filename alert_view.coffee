# setTimeout
delay = (ms, func) -> setTimeout func, ms
# delay 1000, -> something param

$ = jQuery

# jQuery easing
$.extend $.easing,
    avOutExpo: (x, t, b, c, d) -> if t is d then b+c else c * (-Math.pow(2, -10 * t/d) + 1) + b
    avInExpo: (x, t, b, c, d) -> if t is 0 then b else c * Math.pow(2, 10 * (t/d - 1)) + b

# AlertView
$.extend $,
    av:
        version: '1.0.1'
        width: 250
        height: 88
        prefix: 'alert_view_'
        increment_id: 0
        queue: []
        pop: (arg={}) ->
            ###
            pop alert view.
            ###
            arg.expire ?= 5000
            arg.title ?= ''
            arg.message ?= ''
            arg.template ?= 'default'
            arg.mode ?= 'notification'

            aid = @prefix + ++@increment_id
            if arg.mode is 'alert'
                # alert mode
                # you should add the .alert_view_center element in body.
                box = $("""
                      <div id='#{aid}' class='alert_view'>
                          <span class='av_title'>#{arg.title}</span>
                          <span class='av_message'>#{arg.message}</span>
                          <div class='av_close' onclick="$.av.hide('#{aid}');">X</div>
                      </div>
                      """)
                box.css {width: $('.alert_view_center').width()}
                box.css {opacity: 0.0, 'margin-top': '-25px'} if $('.alert_view_center').find('.alert_view').length is 0
                $('.alert_view_center').html(box)

                # alert view animate
                $("##{aid}").animate {opacity: 0.9, 'margin-top': '0'}, 400, 'avOutExpo', if arg.expire > 0 then delay(arg.expire, -> $.av.hide(aid))
            else
                # notification mode
                box = $("""
                      <div id='#{aid}' class='alert_view alert_view_notification'>
                        <div class='av_title'>#{arg.title}</div>
                        <div class='av_message'>#{arg.message}</div>
                      </div>
                      """)

                top = @queue.length * @height
                @queue.push aid
                $('body').append box
                $("##{aid}").css {right: -@width, top: top}

                # alert view animate
                $("##{aid}").animate right: 0, 400, 'avOutExpo', if arg.expire > 0 then delay(arg.expire, -> $.av.hide(aid))
            # add template
            switch arg.template
                when 'error' then box.addClass('alert_view_error')
                when 'black' then box.addClass('alert_view_black')
            aid

        hide: (aid) ->
            ###
            hide alert view.
            ###
            if $("##{aid}").hasClass 'alert_view_notification'
                # notification mode
                $("##{aid}").animate {right: -@width, opacity: 0}, 400, 'avInExpo', ->
                    remove_top = parseInt $(@).css('top')
                    $.av.queue = $.av.queue.filter (x) -> x != aid
                    $(@).remove()
                    for id in $.av.queue
                        $box = $("##{id}")
                        top = parseInt if $box.attr('new_top') then $box.attr('new_top') else $box.css('top')
                        if top >= remove_top
                            top -= $.av.height
                            $box.attr new_top: top
                            $box.dequeue()
                            $box.animate top: top, 400, 'avOutExpo'
            else
                # alert mode
                $("##{aid}").animate opacity: 0.0, 400, -> $(@).remove()
            return
