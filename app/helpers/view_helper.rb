module ViewHelpers
    def json_status(code, response)
      content_type 'application/json'
      status code
      response.to_json
    end

    def json_response(code, response)
      content_type 'application/json'
      status code
      response
    end

    def accept_params(params, fields)
      h = { }
      fields.each do |name|
        h[name] = params[name] if params[name]
      end
      h
    end

    def parse_ar_invalid_errors(invalid)
      record = invalid.record
      status_code = 400
      errors= record.errors.collect do |attribute , error_message|
        if(record.respond_to? "#{attribute}_before_type_cast")
          raw_value= record.send("#{attribute}_before_type_cast")
        else
          begin
            raw_value= record.read_attribute_for_validation(attribute)
          rescue
            # FIXME: read attribute fails for validations on collections. Suppressing the exception as of now. Find a better way
          end
        end
        status_code = 409 if error_message.code == :SC_ALREADY_EXISTS
        {:code => error_message.code , :params=>{:field=> attribute, :value=>raw_value},
         :message=>error_message.message}
      end
      
      json_status status_code,SupplyChainError.new(errors)
    end

    #check if http post request non-null
    def validate_http_request_body(request, symbolize_names=false)
      request.body.rewind
      data = request.body.read
      raise InvalidDataError, {:code=> :SC_INVALID_REQUEST_BODY} if data.empty?
      module_request = JSON.parse(data, :symbolize_names => symbolize_names, :symbolize_keys => symbolize_names)
      raise InvalidDataError, {:code=> :SC_INVALID_REQUEST_BODY} if module_request.empty?
      return module_request
    end
    
    def validate_presence_of(params, keys)
      keys.each do |key|
        raise InvalidDataError.new({:code => :SC_NOT_FOUND, :params => {key => params[key]}, :message => "Please pass the param #{key}"}) if params[key].empty?
      end
    end

    #for custom send data 
    def send_custom_response(response_data,include_data=[],except_data=[], code=200,header_string=nil,content_type="json", methods = [])
      status code
      headers header_string if header_string
      response_data.as_json(:include=>include_data, :except=> except_data, :methods => methods).send("to_#{content_type}")
    end
    
    def generate_search_response(total, rows, node_name, opts = {})
      result = {}
      result["total"]=total
      result["count"]=rows.size
      result[node_name]=rows
      result.to_json(opts)
    end

  end
