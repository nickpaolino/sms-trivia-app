class Message < ApplicationRecord
  belongs_to :user

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
    if self.user.name === "Nick" && self.content = "A9323l"
      self.user.update(permissions: true)
      "You have permission to access all of my data"
    end
  end
end
