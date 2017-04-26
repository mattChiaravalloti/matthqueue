class Question < ApplicationRecord
  belongs_to :queue
  belongs_to :student, class_name: 'Account'
  belongs_to :resolver, class_name: 'Account'
end
