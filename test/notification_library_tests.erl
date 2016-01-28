-module(notification_library_tests).

-include_lib("eunit/include/eunit.hrl").

fixture_startup_test() ->
  application:set_env(slack, slack_token, "test_token"),
  application:set_env(slack, slack_user, "mousetrap"),
  application:set_env(slack, slack_channel, "#moustrap_test"),
  meck:expect(http_uri, encode, 1, "encoded_string"),
  meck:expect(httpc, request, 1, ok).

notify_forwards_to_slack_test() ->
  TestMessage = "Test Message",
  notification_library:notify(TestMessage),
  ?assert(meck:called(httpc, request,
    ["https://slack.com/api/chat.postMessage?token=encoded_string&channel=encoded_string&username=encoded_string&text=encoded_string&link_names=1"])).