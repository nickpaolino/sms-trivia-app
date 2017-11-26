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

    questions =
    [ "",
      "What is the lowest amount of mealpals you can order for a month?",
      "What is the name of Arya's direwolf?",
      "What is the name of me and Nick's module one project?"
    ]

    current_question = questions[@message.number_of_messages]

    text_body = "You're on round #{@message.number_of_messages}"

    sms = @client.messages.create(
      from: "+16467913080",
      to: @message.phone_number,
      body: current_question
    )
  end

  def show
    @messages = Message.all

    render json: @messages
  end
end
