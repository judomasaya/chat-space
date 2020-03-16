json.user_name @message.user.name
json.date @message.created_at.to_s
json.content @message.content
json.image @message.image_url
# idもデータとして渡す
json.id @message.id