class Issue < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user
  validates_presence_of :value
  validates :status, inclusion: { in: ['created', 'approved', 'invalid', 'deleted'] }

end
