module API
  Livolve.controllers :user do

    post '/new', :provides => :json do
      user_request = validate_http_request_body(request, true)
      user = User.new(user_request)
      begin
        user.save!
        status 201
        user.to_json
        # send_custom_response(user, [], [], 201, nil, content_type)
      rescue ActiveRecord::RecordInvalid => e
        status 400
        "Unable to create the user #{e.message}"
        # send_custom_response(
        #     {:message => 'Unable to create the user', :error => e.message},[], [], 400, nil, content_type)
      end
    end

    get '/', :provides => :json do
      users = User.all()
      status 200
      users.to_json
      # send_custom_response(users, [], [], 200, nil, content_type)
    end

    get '/:id', :provides => :json do
      user = User.find(params[:id])
      raise InvalidDataError({:message => "User #{params[:id]} not found"}) if user.blank?
      status 200
      user.to_json
      # send_custom_response(user, [], [], 200, nil, content_type)
    end

    post '/login', :provides => :json do
      user_request = validate_http_request_body(request, true)
      user = User.where({:email => user_request[:email], :auth_token => user_request[:password]})
      if user.blank?
        status 400
        "Invalid Name or Credentials"
        # send_custom_response({:message => 'Invalid Name or Credentials'}, [], [], 400)
      else
        status 200
        user.first.to_json
        # send_custom_response(user.first, [], [], 200, nil, content_type)
    end
  end
  end
end
