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
      "Name one of my three end of module projects"
    ]

    current_question = questions[@message.number_of_messages]

    if @message.number_of_messages == 2
      if @message.content == "6"
        response = "Correct!"
      else
        response = "Nope!"
      end
      message_body = "#{response} #{current_question}"
    elsif @message.number_of_messages == 3
      if @message.content.downcase == "nymeria"
        response = "Nicely done!"
      else
        response = "Sorry but unfortunately that's not it"
      end
      message_body = "#{response} #{current_question}"
    elsif @message.number_of_messages == 4
      if @message.content.downcase.include?("revelize") || @message.content.downcase.include?("cityyelp") || @message.content.downcase.include?("legend of es")
        response = "You got it!"
      else
        response = "Incorrect!"
      end
      message_body = "#{response} #{current_question}"
    elsif @message.number_of_messages == 1
      message_body = current_question
    end

    sms = @client.messages.create(
      from: "+16467913080",
      to: @message.phone_number,
      body: message_body
    )
  end

  def show
    @messages = Message.all

    render json: @messages
  end
end
