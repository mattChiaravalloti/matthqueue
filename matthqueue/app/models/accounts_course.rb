class AccountsCourse < ApplicationRecord
  belongs_to :account
  belongs_to :course

  validates_uniqueness_of :course_id, scope: :account_id
end
