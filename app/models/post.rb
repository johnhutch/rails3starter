class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :as => :parent
  
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
