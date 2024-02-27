Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/ad_parameters', to: 'ad_parameters#index'
    end
  end
end
