require 'rest_client'
module Rest
	def get url,params = {}
		RestClient.get url, {:params => params}
	end

	def post url,params = {}
		RestClient.get url, {:params => params}
	end

	def put url,params = {}
		RestClient.get url, {:params => params}
	end 
end
