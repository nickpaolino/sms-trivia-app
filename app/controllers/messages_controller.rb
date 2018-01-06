class MessagesController < ApplicationController

  def reply
    message_body = params["Body"]
    from_number = params["From"]

    # new_number = encode(from_number)

    @client = Twilio::REST::Client.new ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN']
    sms = @client.messages.create(
      from: "+14015802703",
      to: from_number,
      body: "Hello there Nick."
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

  def mail
    @client = Twilio::REST::Client.new ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN']

    @message = Message.find(params[:id])

    questions =
    [ "",
      "My Belly's Playlist is on ________ St.",
      "Which state did Alex and Es go to college in? (Abbreviation)",
      "Name one of my three end of module projects"
    ]

    current_question = questions[@message.number_of_messages]

    if @message.number_of_messages == 2
      if @message.content.downcase == "washington"
        response = "Correct!"
      else
        response = "Nope!"
      end
      message_body = "#{response} #{current_question}"
    elsif @message.number_of_messages == 3
      if @message.content.downcase == "ri"
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

    phone_number = decode(@message.phone_number)

    sms = @client.messages.create(
      from: "+16467913080",
      to: phone_number,
      body: message_body
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
