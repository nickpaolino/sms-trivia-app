class MessagesController < ApplicationController
 skip_before_filter :verify_authenticity_token

  def reply
    @params = params
    # message_body = params["Body"]
    # from_number = params["From"]
    # boot_twilio
    # sms = @client.messages.create(
    #   from: Rails.application.secrets.twilio_number,
    #   to: from_number,
    #   body: "Hello there, thanks for texting me. Your number is #{from_number}."
    # )
  end

  private

  def boot_twilio
    account_sid = Rails.application.secrets.twilio_sid
    auth_token = Rails.application.secrets.twilio_token
    @client = Twilio::REST::Client.new account_sid, auth_token
  end
end
