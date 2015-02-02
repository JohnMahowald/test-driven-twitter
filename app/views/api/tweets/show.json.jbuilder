json.tweet do
  json.id @tweet.id
  json.content @tweet.content
  json.created_at @tweet.created_at
end
