Livolve.controllers :conversation do

  get '/:user_id/:issue_id', :provides => :json do
    user_id = params[:user_id]
    issue_id = params[:issue_id]
    conversations = Conversation.where({:user_id => user_id, :issue_id => issue_id})
    send_custom_response(conversations)
  end

  get '/:issue_id', :provides => :json do
    issue_id = params[:issue_id]
    conversations = Conversation.where({:issue_id => issue_id})
    send_custom_response(conversations, [:user])
  end

  post '/new', :provides => :json do
    conversation_request = validate_http_request_body(request, true)
    conversation_request.merge!({:is_solution => 'N'})
    conversation = Conversation.create(conversation_request)
    conversation.save!
    send_custom_response(conversation, [], [], 201)
  end

  put '/:id/solution', :provides => :json do
    conversation = Conversation.find(params[:id])
    conversation.update_attributes!({:is_solution => 'Y'})
    status 204
  end

end