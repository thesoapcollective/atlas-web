Rails.application.routes.draw do
  root 'static#home'

  devise_for :users

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
