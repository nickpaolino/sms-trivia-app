Rails.application.routes.draw do

  resource :messages do
    collection do
      post 'reply'
      post '/mail/:id', to: 'messages#mail', as: 'mail'
    end
  end

  root to: 'messages#main'
end
