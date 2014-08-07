class Invitation < ActiveRecord::Base
  belongs_to :issue
  belongs_to :user
  validates_presence_of :user
  validates_presence_of :issue
  validates :status, inclusion: { in: ['accepted', 'declined', 'pending'] }
  validates_uniqueness_of :issue_id, :scope => [:user_id]
end
