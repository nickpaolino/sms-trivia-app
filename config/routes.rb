Rails.application.routes.draw do

  resource :messages do
    collection do
      post 'reply'
      post 'send'
    end
  end

  root to: 'messages#main'
end
