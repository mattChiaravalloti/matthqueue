class OhTimeSlot < ApplicationRecord
  belongs_to :course
  has_many :oh_queues
end
