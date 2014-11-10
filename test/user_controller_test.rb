require_relative '../test/lib/test_helper.rb'
class UserControllerTest < LivolveTestCase

	context 'User Controller' do
		setup do
		end

	    should 'create new user' do
			post "/user/new",{"team_id" => 1,"auth_token" => "123","name" => "Gopala","email" => "gopal.kr@flipkart1.com","role" => "DEV"}
			p last_response.body
			assert_equal last_response.status , 202
		end
	end
end