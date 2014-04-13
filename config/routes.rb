Itedd::Application.routes.draw do

  get 'embedded' => 'embedded#index'
  get 'embedded/embedded' => 'embedded#show'
  get 'embedded/embedded_calendar' => 'embedded#calendar', as: :embedded_calendar

  get 'events/restore/:id' => 'events#restore', as: :restore_event

  devise_for :users

  resource :welcomes
  resources :user_groups
  resources :events
  resources :user_admins
  resources :user_group_admins

  get 'user_admins/:id/:action_id' => 'user_admins#set', as: :user_admin_set

  get 'impressum' => 'welcomes#impressum', as: :impressum
  get 'faq' => 'welcomes#faq', as: :faq

  root 'welcomes#show'
end
