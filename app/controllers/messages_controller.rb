class MessagesController < ApplicationController

  def reply
    account_sid = ""
    auth_token = ""
    @client = Twilio::REST::Client.new ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN']
    message_body = params["Body"]
    from_number = params["From"]
    sms = @client.messages.create(
      from: "+1646791080",
      to: from_number,
      body: "Hello #{from_number}, thanks for texting me."
    )
  end
end
