require 'spec_helper'

describe PaymentsController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'confirm'" do
    it "returns http success" do
      get 'confirm'
      response.should be_success
    end
  end

  describe "GET 'complete'" do
    it "returns http success" do
      get 'complete'
      response.should be_success
    end
  end

end
