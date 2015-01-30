json.tweet do
  json.content @tweet.content
  json.created_at @tweet.created_at
  json.id @tweet.id
end
