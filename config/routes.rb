Rails.application.routes.draw do
  get("/", { :controller => "pages", :action => "home" })

  get("/weather/:address", { :controller => "forecasts", :action => "weatheroutput" })
end
