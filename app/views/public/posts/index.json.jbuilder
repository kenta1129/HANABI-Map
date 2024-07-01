json.data do
  json.items do
    json.array!(@posts) do |post|
      json.id post_image.id
      json.user do
        json.name post.user.name
        json.image url_for(post.user.profile_image)
      end
      json.image url_for(post.image)
      json.shop_name post.shop_name
      json.caption post.caption
      json.address post.address
      json.latitude post.latitude
      json.longitude post.longitude
    end  
  end
end