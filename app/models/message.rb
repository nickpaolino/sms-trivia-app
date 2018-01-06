class Message < ApplicationRecord

  def number_of_messages
    number = self.phone_number
    message_count = Message.all.select {|msg| msg.phone_number == number}.count

    message_count
  end

  def resolve_response
    message = self.determine_sender
    message
  end

  def determine_sender
    if self.phone_number == "+14015802703"
      "Hello Nick"
    end
  end
end
