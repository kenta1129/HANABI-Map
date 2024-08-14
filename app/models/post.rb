class Post < ApplicationRecord
  
  belongs_to :user
  
  has_many :post_comments, dependent: :destroy
  
  has_many :favorites, dependent: :destroy
  
  has_many :notifications, as: :notifiable, dependent: :destroy
  
  has_one_attached :profile_image
  
  validates :title, presence: true
  validates :body, {presence: true, length: {maximum:200}}
  validates :latitude, presence: true
  validates :longitude, presence: true
  
  # validates :address, presence: true

  geocoded_by :address
  after_validation :geocode
  
  def self.search_for(content, method)
    if method == 'perfect'
      Post.where(title: content)
    elsif method == 'forward'
      Post.where('title LIKE ?', content + '%')
    elsif method == 'backward'
      Post.where('title LIKE ?', '%' + content)
    else
      Post.where('title LIKE ?', '%' + content + '%')
    end
  end
  
  def favorited_by?(user)
     favorites.exists?(user_id: user.id)
  end
  
  after_create do
    user.followers.each do |follower|
      notifications.create(user_id: follower.id)
    end
  end  
  
  
  def get_profile_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
     profile_image.variant(resize_to_limit: [50, 50]).processed
  end
  
end
