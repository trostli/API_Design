@@db = FakeDB.instance

before do
  content_type :json
end

get '/' do
  { msg: "ok!" }.to_json
end

post '/sign_up' do
  email = params["email"]
  if User.create(email)
    { success: "created user with email #{email}" }.to_json
  end
end

post '/sign_in' do
  email = params["email"]
  access_token = params["access_token"]
  user = User.sign_in(email, access_token)
end

post '/create_post' do
  post = Post.create(params["text"])
  if post
    { success: "created post with ID #{@@db.posts.length - 1}", post: post.user.email }.to_json
  end
end

get '/list_posts' do
  posts = Post.get_posts
  { posts: posts }.to_json
end

post '/edit_post/:id/' do
  id = params["id"]
  new_text = params["text"]
  post = @@db.posts[id]
  post.edit(new_text)
  { sucess: 'edited' }.to_json
end

delete '/delete_post' do
  id = params["id"]
  Post.delete(id)
  { success: "post deleted" }.to_json
end