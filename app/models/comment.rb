class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :parent, :polymorphic => true
  validates_presence_of :body
end
