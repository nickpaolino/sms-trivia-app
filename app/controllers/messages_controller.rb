class MessagesController < ApplicationController

  def reply
    account_sid = "AC886c0ecb9e6927e801c5bda667258431"
    auth_token = "70ffa9a31541fb3b612eff826e94a89f"
    @client = Twilio::REST::Client.new account_sid, auth_token
    message_body = params["Body"]
    from_number = params["From"]
    sms = @client.messages.create(
      from: "+16467913080",
      to: from_number,
      body: "Hello #{from_number}, thanks for texting me."
    )
  end
end
