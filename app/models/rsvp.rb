class Rsvp < ApplicationRecord
    belongs_to :guest, class_name: 'User', foreign_key: 'guest_id'
    belongs_to :event
    
    validates :guest_id, presence: true
    validates :event_id, presence: true
    validates :status, presence: true, inclusion: { in: %w[pending accepted declined] }

end
  