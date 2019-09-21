Rails.application.routes.draw do
  resources :admins
  resources :librarians
  resources :students
  resources :books
  resources :libraries
  get 'book/show'
  get 'book/edit'
  get 'book/destroy'
  get 'book/create'
  get 'book/new'
  get 'urls/new'

  root 'students#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
