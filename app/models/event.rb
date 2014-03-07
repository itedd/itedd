class Event < ActiveRecord::Base
  scope :upcoming_events, -> { oldest_first.where('happens_at >= :now', now: Time.now) }
  scope :finished_events, -> { newest_first.where('happens_at < :now',  now: Time.now) }

  scope :oldest_first, -> { order('happens_at asc') }
  scope :newest_first, -> { order('happens_at desc') }

  scope :for_user_group, -> (ug) { where('user_group_id=?', ug.id) if ug.present? }
  scope :for_user_groups, -> (ugs) { where('user_group_id IN (?)', ugs.map{|ug| ug.id}) if ugs.present? }

  belongs_to :user_group

  validates_presence_of :link
  validates_presence_of :text
  validates_presence_of :happens_at
  validates_presence_of :user_group
  validates_length_of   :link, :maximum => 200
  validates_length_of   :text, :maximum => 200
end
