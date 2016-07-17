Rails.application.routes.draw do
  resources :searches, only: [:new, :create] do
    resources :job_results, only: :index
  end
  root 'searches#new'
end
