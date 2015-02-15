json.tweet do 
  json.id @tweet.id
  json.user_id @tweet.user_id
  json.content @tweet.content
  json.created_at @tweet.created_at
  json.updated_at @tweet.updated_at
end
