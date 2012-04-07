require 'spec_helper'

describe "Photos" do
  let(:user) {FactoryGirl.create(:user)}
  let(:admin) {FactoryGirl.create(:admin)}
  let(:author) {FactoryGirl.create(:author)}
  let(:uploader) {FactoryGirl.create(:uploader)}
  let(:uploader2) {FactoryGirl.create(:uploader2)}

  let(:photo) { FactoryGirl.create(:photo, user: uploader) }
  let(:photo2) { FactoryGirl.create(:photo, user: uploader) }
  let(:photo3) { FactoryGirl.create(:photo, user: uploader) }

  describe "GET /photos" do
    it "displays photos" do
      photo
      photo2
      photo3

      visit photos_path
      page.should have_css('img', :src => photo.image.url(:thumb))
      page.should have_css('img', :alt => photo.title)
      page.should have_css('img', :alt => photo2.title)
      page.should have_css('img', :alt => photo3.title)
    end
  end
end
