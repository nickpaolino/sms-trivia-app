class MessagesController < ApplicationController

  def reply
    message_body = params["Body"]
    from_number = params["From"]

    @message = Message.create(content: message_body, phone_number: from_number)

    redirect_to mail_messages_path(@message)
  end

  def mail
    @client = Twilio::REST::Client.new ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN']

    @message = Message.find(params[:id])
    sms = @client.messages.create(
      from: "+16467913080",
      to: @message.phone_number,
      body: "Hello #{@message.phone_number}, thanks for texting me this: #{@message.content}."
    )
  end

  def show
    @messages = Message.all

    render json: @messages
  end
end
