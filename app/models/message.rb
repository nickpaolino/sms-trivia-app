class Message < ApplicationRecord

  def number_of_messages
    number = self.phone_number
    message_count = Message.all.select {|msg| msg.phone_number == number}.count

    message_count
  end
end
