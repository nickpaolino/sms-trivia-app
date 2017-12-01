Rails.application.routes.draw do

  resource :messages do
    collection do
      post 'reply'
      post '/mail/:id', to: 'messages#mail', as: 'mail'
    end
  end
  post '/:message/xml', to: 'messages#view_xml', as: 'xml'
  post '/:message/call', to: 'messages#call', as: 'call'
  root to: 'messages#main'
end
