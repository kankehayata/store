Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "posts#index"
  resources :posts do
    collection{ post "search"}
    member{
      post "edit_save"
      get "get_image"
    }
  end
=begin
  namespace :api, format: "json" do
    namespace :v1 do
      root "posts#index"
      resources :posts do
        collection{ get "search"}
        member{
          post "edit_save"
          get "get_image"
        }
      end
    end
  end
=end
end
