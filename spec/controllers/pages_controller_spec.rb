require 'spec_helper'

describe PagesController do

  describe "GET 'pricing'" do
    it "returns http success" do
      get 'pricing'
      response.should be_success
    end
  end

  describe "GET 'index'" do
    it "returns http success" do
      get root_path
      response.should be_success
    end
  end

  describe "GET 'subscribe'" do
    it "returns http success" do
      get 'subscribe'
      response.should be_success
    end
  end
end
