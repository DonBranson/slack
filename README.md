Slack
===

This is an minimal OTP library for sending slack notifications. "At targets" are supported. (@channel, @here, etc.)

Requirements
===

* Erlang runtime system. I used [kerl](https://github.com/yrashk/kerl) to install 17.4 at /home/root/erlangs/17.4
* A [Slack account](http://slack.com) with an [authentication token](https://api.slack.com/web#basics) and a channel for posting

Sample Config
===

    [
        {slack, [
            {slack_user, "mousetrap"},
            {slack_channel, "#mousetrap"},
            {slack_token, "<slack token here>"}
        ]}
    ].


Sample Slack Messages
===

    mousetrap BOT [7:40 PM]
    Mousetrap starting
    Start pin_server_5 watching pin {pin,gpio0,5,"4 (Not yet wired)"} (now closed) and notifying mousetrap_server
    Start pin_server_48 watching pin {pin,gpio1,16,"3 (in the kitchen pantry)"} (now closed) and notifying mousetrap_server
    Start pin_server_31 watching pin {pin,gpio0,31,"2 (by basement freezer)"} (now closed) and notifying mousetrap_server
    Start pin_server_30 watching pin {pin,gpio0,30,"1 (over workshop door)"} (now closed) and notifying mousetrap_server

    mousetrap BOT [12:44 AM]
    Mousetrap '3 (in the kitchen pantry)' has caught a mouse.

    mousetrap BOT [7:46 AM]
    Mousetrap '3 (in the kitchen pantry)' has been reset.

Using in your erlang.mk-based project:
===

Add this to your sys.config, replacing with your token, which you can generate at https://api.slack.com/web:

    {slack, [
      {slack_user, "mousetrap"},
      {slack_channel, "#mousetrap-beta"},
      {slack_token, "<your slack token here>"}
    ]}

Add to your Makefile:

    DEPS = slack

Include inets, ssl, and slack in your app.src file:

    {applications, [
        kernel,
        stdlib,
        inets,
        ssl,
        slack
    ]},

You can use either of these functions to send notifications. The first uses the settings configured in your sys.config: 

    notification_library:notify("@channel Mousetrap starting"),
    notification_library:notify(Token, SlackChannel, UserName, Message, "@channel Mousetrap starting"),
