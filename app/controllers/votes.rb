post '/event/:e_id/restaurant/:r_id/vote' do
	votes_params = {user_id: logged_user.id, event_id: params[:e_id]}
	vote = Vote.find_by(votes_params)
	redirect "/event/#{params[:e_id]}?error=already_voted" if vote
	new_vote = Vote.new
	new_vote.restaurant = Restaurant.find(params[:r_id])
	new_vote.user = logged_user
	event = Event.find(params[:e_id])
	new_vote.event = event
	new_vote.save
	redirect "/event/#{event.id}/results" if (event.votes - event.restaurants.uniq) >= event.group.members.count
	redirect "/event/#{event.id}"
end