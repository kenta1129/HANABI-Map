class Post < ApplicationRecord
  
  belongs_to :user
  
  has_many :post_comments, dependent: :destroy
  
  has_many :favorites, dependent: :destroy
  
  has_one_attached :profile_image
  
  validates :title, {presence: true}
  validates :body, {presence: true, length: {maximum:200}}
  
  # validates :address, presence: true

  geocoded_by :address
  after_validation :geocode
  
  def self.search_for(content, method)
    if method == 'perfect'
      Post.where(body: content)
    elsif method == 'forward'
      Post.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      Post.where('name LIKE ?', '%' + content)
    else
      Post.where('name LIKE ?', '%' + content + '%')
    end
  end
  
  def favorited_by?(user)
     favorites.exists?(user_id: user.id)
  end
  
  
  
  def get_profile_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
  
end
