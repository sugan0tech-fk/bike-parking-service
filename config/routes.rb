Rails.application.routes.draw do

  post "load-entry", to: "parking#load_data"
  post "make-entry", to: "parking#add_data"
  get "lock", to: "parking#set_lock"
  get "max-time", to: "parking#max_time"
  get "max-frequency", to: "parking#max_frequnecy"

end
