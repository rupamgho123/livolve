class Team < ActiveRecord::Base
  validates_presence_of :name, :auth_token
end
