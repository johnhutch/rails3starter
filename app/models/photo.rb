class Photo < ActiveRecord::Base
  belongs_to :user
  belongs_to :owner, :polymorphic => true

  before_create :default_name
  
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  validates_attachment :image, :presence => true,
    :size => { :in => 1..5000.kilobytes }

  def default_name
    self.title ||= File.basename(image.original_filename, '.*').titleize if image
  end
end
