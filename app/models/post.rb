class Post < ApplicationRecord
  
  belongs_to :user
  
  validates :body, {presence: true, length: {maximum:200}}
  
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
  
end
