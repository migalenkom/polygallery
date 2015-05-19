require 'rails_helper'

RSpec.describe "photo/index.html.erb", :type => :view do
  it "should contain the search input" do
    render
    expect(rendered).to have_css("input#search_input")
  end
end