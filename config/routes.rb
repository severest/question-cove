Rails.application.routes.draw do
  resources :questions
  post '/questions/:id/up', to: 'questions#voteup', as: 'questionup'
  post '/questions/:id/down', to: 'questions#votedown', as: 'questiondown'
  post '/questions/:id/best_answer', to: 'questions#best_answer', as: 'best_answer'
  post '/questions/:id/pingslack', to: 'questions#remind_on_slack', as: 'remind_on_slack'

  resources :answers, only: [:create, :edit, :update, :destroy]
  post '/answers/:id/up', to: 'answers#voteup', as: 'answerup'
  post '/answers/:id/down', to: 'answers#votedown', as: 'answerdown'

  resources :users, only: [:show, :edit, :update]

  resources :comments, only: [:create, :destroy, :update]

  get '/tags', to: 'questions#get_tags_like', as: 'search_tags'

  root 'questions#index'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/emails"
  end

  get '/notloggedin', to: 'sessions#new', as: 'login'
  get '/notallowed', to: 'sessions#denied', as: 'not_allowed'
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get 'amialive', to: 'healthcheck#amialive'
end
