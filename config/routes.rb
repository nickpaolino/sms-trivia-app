Rails.application.routes.draw do

  resource :messages do
    collection do
      post 'reply'
      post '/mail/:id', to: 'messages#mail', as: 'mail'
    end
  end
  post '/xml', to: 'messages#view_xml'
  get '/call', to: 'messages#call'
  root to: 'messages#main'
end
