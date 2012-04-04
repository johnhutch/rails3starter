require 'spec_helper'

describe "photos/new" do
  before(:each) do
    assign(:photo, stub_model(Photo,
      :caption => "MyString",
      :title => "MyString",
    ).as_new_record)
  end

  it "renders new photo form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => photos_path, :method => "post" do
      assert_select "input#photo_caption", :name => "photo[caption]"
      assert_select "input#photo_title", :name => "photo[title]"
    end
  end
end
