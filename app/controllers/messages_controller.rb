class MessagesController < ApplicationController

  def reply
    message_body = params["Body"]
    from_number = params["From"]

    # new_number = encode(from_number)

    user = User.find_or_create_by(phone_number: from_number)
    byebug
    message = Message.create(content: message_body, phone_number: from_number, user_id: user.id)
    user.messages << message

    resolved_message = message.resolve_response

    @client = Twilio::REST::Client.new ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN']
    sms = @client.messages.create(
      from: ENV['TWILIO_PHONE'],
      to: from_number,
      body: "Test"
    )
  end

  def view_xml
    message = params[:message].split("_").join(" ")
    data = {:Say => message}
    render :xml => data.to_xml(root: 'Response')
  end

  def call
    @client = Twilio::REST::Client.new ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN']

    message = params[:message].split("-")[-1]
    phone_number = params[:message].split("-")[0]

    @client.calls.create(
      to: phone_number,
      from: ENV['TWILIO_PHONE'],
      url: "https://sms-trivia-app.herokuapp.com/#{message}/xml"
    )
  end

  def show
    @messages = Message.all

    render json: @messages
  end

  private

  def encode(characters)
    encoded_array = []

    characters.each_char do |char|
      encoded_array << char.ord
    end

    return encoded_array.join("/")
  end

  def decode(characters)
    word = []
    characters.split("/").each do |char|
      word << eval(char).chr
    end

    return word.join("")
  end
end
