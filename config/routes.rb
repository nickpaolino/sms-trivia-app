Rails.application.routes.draw do

  resource :messages do
    collection do
      post 'reply'
      get 'mail'
    end
  end

  root to: 'messages#main'
end
