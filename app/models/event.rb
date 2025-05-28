class Event < ApplicationRecord
    belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
    has_many :rsvps, dependent: :destroy
    has_many :attendees, through: :rsvps, source: :guest

    validates :title, presence: true

    def invite_guests(user_ids)
         user_ids.each do |user_id|
            rsvps.create(guest_id: user_id, status: 'pending')
        end
    end

    def invite_guest(user)
        invite_guests([user.id])
    end
end
