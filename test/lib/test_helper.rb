require "test/unit"
require "shoulda/context"
require "rack/test"
require "padrino"
include Rack::Test::Methods
class LivolveTestCase < Test::Unit::TestCase
	def app
		Livolve.new
	end	
end