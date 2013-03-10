
$ ->
    # -------------------------- alert --------------------------
    # center alert
    $(document).on 'click', 'a.center_msg', ->
        $.av.pop
            mode: 'alert'
            title: 'Title'
            message: 'AlertView is an alert division which is a jQuery extension. It is like OS X notification window, or Twitter alert message.'
        false

    # center alert, error template
    $(document).on 'click', 'a.center_error_msg', ->
        $.av.pop
            mode: 'alert'
            template: 'error'
            title: 'Title'
            message: 'AlertView is an alert division which is a jQuery extension. It is like OS X notification window, or Twitter alert message.'
        false

    # center alert, black template
    $(document).on 'click', 'a.center_black_msg', ->
        $.av.pop
            mode: 'alert'
            template: 'black'
            title: 'Title'
            message: 'AlertView is an alert division which is a jQuery extension. It is like OS X notification window, or Twitter alert message.'
        false

    # -------------------------- notification --------------------------
    # right notification
    $(document).on 'click', 'a.right_msg', ->
        $.av.pop
            title: 'Title'
            message: 'AlertView is an alert division which is a jQuery extension.'
        false

    # right notification, error template
    $(document).on 'click', 'a.right_error_msg', ->
        $.av.pop
            template: 'error'
            title: 'Error!'
            message: 'AlertView is an alert division which is a jQuery extension.'
        false

    # right notification, black template
    $(document).on 'click', 'a.right_black_msg', ->
        $.av.pop
            template: 'black'
            title: 'Black'
            message: 'AlertView is an alert division which is a jQuery extension.'
        false