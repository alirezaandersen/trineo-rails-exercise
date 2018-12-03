Rails.application.routes.draw do

  resources :todos do
    resources :items
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      resources :todos, module: 'todos' do
        collection do
          get '/completed',     to: 'todos#completed'
          get '/not_completed', to: 'todos#not_completed'
        end
      end

    end
  end

end
