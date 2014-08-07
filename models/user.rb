require 'validates_timeliness'
class User < ActiveRecord::Base
  has_many :issue
  belongs_to :team
  has_many :conversation
  has_many :issue
  validates_uniqueness_of :email, :name
  validates_presence_of :name, :email, :auth_token, :team_id, :role
  validates_presence_of :team
end
