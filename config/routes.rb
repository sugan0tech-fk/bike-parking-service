Rails.application.routes.draw do

  post "make-entry", to: "parking#load_data"
  get "max-time", to: "parking#max_time"
  get "max-frequency", to: "parking#max_frequnecy"

end
