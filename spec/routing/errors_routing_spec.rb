require "spec_helper"

describe ErrorsController do
  describe "routing" do

    it "routes to #index" do
      get("/errors").should route_to("errors#index")
    end

    it "routes to #new" do
      get("/errors/new").should route_to("errors#new")
    end

    it "routes to #show" do
      get("/errors/1").should route_to("errors#show", :id => "1")
    end

    it "routes to #edit" do
      get("/errors/1/edit").should route_to("errors#edit", :id => "1")
    end

    it "routes to #create" do
      post("/errors").should route_to("errors#create")
    end

    it "routes to #update" do
      put("/errors/1").should route_to("errors#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/errors/1").should route_to("errors#destroy", :id => "1")
    end

  end
end
