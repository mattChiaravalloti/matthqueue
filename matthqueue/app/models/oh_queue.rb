class OhQueue < ApplicationRecord
  belongs_to :course
  has_many :questions
end
