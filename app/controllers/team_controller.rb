Livolve.controllers :team do

  get '/:team_id/users',  :provides => :json do
    team_id = params[:team_id]
    users = User.where({:team_id => team_id})
    send_custom_response(users)
  end

  get '/:team_id', :provides => :json do
    team = Team.find(params[:team_id])
    send_custom_response(team)
  end

  post '/new', :provides => :json do
    team_request = validate_http_request_body(request, true)
    team = Team.create(team_request)
    team.save!
    send_custom_response(team, [], [], 201)
  end
end