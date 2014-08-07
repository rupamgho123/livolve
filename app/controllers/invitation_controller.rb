Livolve.controllers :invite do

  post '/new', :provides => :json do
    invite_request = validate_http_request_body(request, true)
    invite = Invitation.create(invite_request.merge!({:status => 'pending'}))
    invite.save!
    send_custom_response(invite, [], [], 201)
  end

  post '/bulk', :provides => :json do
    bulk_invite_request = validate_http_request_body(request, true)
    user_ids = bulk_invite_request[:users]
    issue_id = bulk_invite_request[:issue_id]
    user_ids.each do |user_id|
      invite = Invitation.create({:issue_id => issue_id, :user_id => user_id, :status => 'pending'})
      invite.save!
    end
    status 200
  end

  get '/:user_id/:status', :provides => :json do
    user_id = params[:user_id]
    status = params[:status]
    invitations = Invitation.where({:user_id => user_id, :status => status})
    send_custom_response(invitations)
  end

  get '/:user_id/:status/issues', :provides => :json do
    user_id = params[:user_id]
    status = params[:status]
    invitations = Invitation.where({:user_id => user_id, :status => status})
    issues = []
    invitations.each do |invite|
      issues << Issue.find(invite[:id])
    end
    send_custom_response(issues)
  end

  put '/:id/status/:status', :provides => :json do
    invite_id = params[:id]
    status = params[:status]
    invite = Invitation.find(invite_id)
    invite.update_attributes!({:status => status})
    status 204
  end
end