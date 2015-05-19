require 'rails_helper'

RSpec.describe "photo/search.html.erb", :type => :view do
  it "should contain the search input" do
    controller = PhotoController.new
    controller.params = { :search_input => 'cats' }
    assign(:results, controller.search)
    render
    expect(rendered).to have_css("input#search_input")
  end

  it "should contain thumbnails" do
    controller = PhotoController.new
    controller.params = { :search_input => 'cats' }
    assign(:results, controller.search)
    render
    expect(rendered).to have_css(".thumbs img", :count => 8)
  end

  it "should contain links to larger images" do
    controller = PhotoController.new
    controller.params = { :search_input => 'cats' }
    assign(:results, controller.search)
    render
    expect(rendered).to include("_c.jpg")
  end
end