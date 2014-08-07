class Conversation < ActiveRecord::Base
  belongs_to :issue
  belongs_to :user
  validates_presence_of :issue, :user
  validates :is_solution, inclusion: { in: ['Y', 'N'] }
  validates_presence_of :value
end
