DirectContact::Application.routes.draw do
  root 'contacts#index'

  mount Sidekiq::Web, at: 'sidekiq'
  mount StripeEvent::Engine => 'stripe'

  get 'pricing', to: 'pages#pricing', as: 'pricing'
  get 'policies', to: 'pages#policies', as: 'policies'

  get 'cookie_test', to: 'application#cookie_test', as: 'cookies_test'

  devise_for :users, controllers: { registrations: 'registrations' },
  path_names: { sign_in: 'login', sign_out: 'logout' }
  devise_scope :user do
    put 'update_plan', to: 'registrations#update_plan'
    put 'update_card', to: 'registrations#update_card'
    put 'cancel_plan', to: 'registrations#cancel_plan'
  end

  resources :users
end
