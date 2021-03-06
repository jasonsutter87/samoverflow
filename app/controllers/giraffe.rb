post '/posts/:id' do
    post = Post.find(params[:id])
    user = User.find(session[:user_id])
  if request.xhr? && session[:user_id] != nil && Vote.where(user_id: user.id, voteable_id: post.id, voteable_type: "Post").empty?
    vote = Vote.create({user_id: user.id, voteable_id: post.id, voteable_type: "Post"})
    content_type :json
    {points: post.votes.count}.to_json
  else
    redirect '/'
  end
end

# && vote.user_id != user.id

delete '/posts/:id' do
    post = Post.find(params[:id])
    vote = Vote.where(voteable_id: post.id)
    vote = vote.first
    Vote.destroy(vote.id)
  if request.xhr? && session[:user_id] != nil
    content_type :json
    {points: post.votes.count}.to_json
  else
    redirect '/'
  end
end
