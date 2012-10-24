class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :as => :parent
  has_many :photos, :as => :owner
  
  accepts_nested_attributes_for :photos, :reject_if => lambda { |a| a[:image].blank? }, :allow_destroy => true

  validates_presence_of :title, :body
  
  attr_accessible :title, :body, :photos_attributes

  def publish_me
    self.published = true
    self.published_at = Time.now
  end

  def published?
    self.published ? self.published_string : "Not published"
  end
  
  def published_string
    published.strftime('%m/%e at %l:%M %p').gsub("12:00 PM", "Noon") unless published.nil?
  end
  
  def published_string=(published_str)
    self.published = Time.parse(published_str.gsub("Noon", "12:00 PM"))
  rescue ArgumentError
    @published_invalid = true
  end
end
