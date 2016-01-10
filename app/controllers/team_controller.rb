Livolve.controllers :team do

  get '/', :provides => :json do
    Team.all.to_json
  end

  get '/:team_id/users',  :provides => :json do
    team_id = params[:team_id]
    users = User.where({:team_id => team_id})
    status 200
    users.to_json
    # send_custom_response(users)
  end

  get '/:team_id', :provides => :json do
    team = Team.find(params[:team_id])
    status 200
    team.to_json
    # send_custom_response(team)
  end

  post '/new', :provides => :json do
    team_request = validate_http_request_body(request, true)
    team = Team.create(team_request)
    team.save!
    status 201
    team.to_json
    # send_custom_response(team, [], [], 201)
  end
end