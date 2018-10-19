class MessagesController < ApplicationController

  def reply
    message_body = params["Body"]
    
    phone_number = message_body.split("-")[-1][1..-1]
    # new_message = message_body.split("set_message")[-1][1..-1].split(" ").join("_")
    new_message = message_body.split(" ").join("_")
    redirect_to call_url(new_message)
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
