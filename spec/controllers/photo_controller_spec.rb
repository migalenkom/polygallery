require 'rails_helper'

RSpec.describe PhotoController, :type => :controller do
  describe "when loading the initial page" do
    it "should return the success HTTP code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(:success)
    end

    it "should render the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "should load no results" do
      get :index
      expect(assigns(:results)).to be_empty
    end
  end

  describe "when searching for photos" do
    it "should return an error if empty search" do
      post :search, :search_input => ""
      expect(flash[:error_msg]).to eq("Please enter some text to search for...")
    end

    it "should return an error if whitespace search" do
      post :search, :search_input => "    "
      expect(flash[:error_msg]).to eq("Please enter some text to search for...")
    end

    it "should return maximum items for a popular search" do
      post :search, :search_input => "cats"
      expect(assigns(:results).length).to eq(AppConfig.results_per_page)
    end

    it "should return zero items for a rubbish search" do
      post :search, :search_input => "djsaljdkasjd79371289312jkdsajlkdj"
      expect(assigns(:results).length).to eq(0)
    end

    it "should contain different results on page 2" do
      post :search, :search_input => "cats"
      list1 = assigns(:results)

      post :search, :search_input => "cats", :page => 2
      list2 = assigns(:results)

      expect(list1).not_to match_array(list2)
    end
  end

  # DRY not followed because before(:all) doesn't allow us to fetch the API call just once
  describe "when FlickRaw::Response generates a thumbnail" do
    it "should build a correct thumbnail image URL" do
      post :search, :search_input => "cats"
      response = assigns(:results)[0]
      url_template = "https://farm#{response.farm}.staticflickr.com/#{response.server}/#{response.id}_#{response.secret}"

      expect(response.url_q).to eq(url_template + "_q.jpg")
    end

    it "should build a correct large image URL" do
      post :search, :search_input => "cats"
      response = assigns(:results)[0]
      url_template = "https://farm#{response.farm}.staticflickr.com/#{response.server}/#{response.id}_#{response.secret}"

      expect(response.url_c).to eq(url_template + "_c.jpg")
    end
  end
end