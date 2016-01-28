-module(notification_library).

-import(http_uri, [encode/1]).
-export([notify/1, notify/4]).

notify(Message) ->
  {ok, UserName} = application:get_env(slack, slack_user),
  {ok, SlackChannel} = application:get_env(slack, slack_channel),
  {ok, Token} = application:get_env(slack, slack_token),
  notify(Token, SlackChannel, UserName, Message).

notify(Token, SlackChannel, UserName, Message) ->
  URL = lists:flatten(io_lib:format("https://slack.com/api/chat.postMessage?token=~s&channel=~s&username=~s&text=~s&link_names=1", [
    encode(Token), encode(SlackChannel), encode(UserName), encode(Message)
  ])),
  httpc:request(URL).