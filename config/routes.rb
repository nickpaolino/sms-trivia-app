Rails.application.routes.draw do

  resource :messages do
    collection do
      post 'reply'
      post '/mail/:id', to: 'messages#mail', as: 'mail'
    end
  end

  get '/call', to: 'messages#call'
  root to: 'messages#view_xml'
end
