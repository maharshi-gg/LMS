Rails.application.routes.draw do

  # so that only authenticated user can access these pages.
  # Refer: https://github.com/plataformatec/devise/wiki/How-To:-Require-authentication-for-all-pages
  # and https://github.com/plataformatec/devise/wiki/How-To:-Define-resource-actions-that-require-authentication-using-routes.rb
  authenticate :user do
    get 'homepage', to: 'test_home_page#index', as: 'user_homepage'
    get 'home/index'
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
  end

  root 'home#index'
  get 'page2', to: 'page2#index', as: 'page2'

  devise_for :users, :controllers => { registrations: 'registrations'}




  # devise_scope :user do
  #   # to change the page displayed after sign in. Refer: https://stackoverflow.com/a/25243422/6543250
  #   get 'user_root', :to => 'registrations#after_sign_in_path_for'
  # end


  root 'students#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
