
  Livolve.controllers :issue do

    post '/new', :provides => :json do
      user_request = validate_http_request_body(request, true)
      issue = Issue.new(user_request.merge!({:status => 'created'}))
      begin
        issue.save!
        send_custom_response(issue, [], [], 201)
      rescue ActiveRecord::RecordInvalid => e
        send_custom_response(
            {:message => 'Unable to create the issue', :error => e.message},[], [], 400, nil, content_type)
      end
    end

    get '/:user_id', :provides => :json do
      issues = Issue.where({:user_id => params[:user_id]})
      send_custom_response(issues)
    end

    put '/:id/status/:status', :provides => :json do
      issue = Issue.where({:id => params[:id]})
      raise InvalidDataError.new({:message => "No issue found with id : #{params[:id]}"}) if issue.blank?
      begin
        issue.update_attributes!({:status => params[:status]})
        send_custom_response({:message => 'Success'}, [], [], 204, nil, content_type)
      rescue ActiveRecord::RecordInvalid => e
        send_custom_response(
            {:message => 'Unable to change the status of issue', :error => e.message},[], [], 400, nil, content_type)
      end
      {:a => 1}
    end
  end

