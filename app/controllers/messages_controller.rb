class MessagesController < ApplicationController

  def reply
    account_sid = ""
    auth_token = ""
    @client = Twilio::REST::Client.new account_sid, auth_token
    message_body = params["Body"]
    from_number = params["From"]
    sms = @client.messages.create(
      from: "+",
      to: from_number,
      body: "Hello #{from_number}, thanks for texting me."
    )
  end
end
