class Event < ActiveRecord::Base
  acts_as_paranoid

  validates :link, presence: true, length: {maximum: 200}
  validates :text, presence: true, length: {maximum: 200}
  validates :happens_at, presence: true
  validates :user_group, presence: true

  belongs_to :user_group

  scope :oldest_first, -> { order happens_at: :asc }
  scope :newest_first, -> { order happens_at: :desc }

  before_update :check_link

  def check_link
    if link && !link.start_with?('http://') && !link.start_with?('https://')
      self.link = "http://#{link}"
    end
  end

  class << self
    def upcoming(after = Time.now)
      oldest_first.where arel_table[:happens_at].gteq(after)
    end
    def finished(since = Time.now)
      newest_first.where arel_table[:happens_at].lt(since)
    end

    def for_user_group(user_group_id)
      if user_group_id.is_a? UserGroup
        id = user_group_id.id
      else
        id = user_group_id
        id = id.to_i if id
      end
      if id && id != 0
        where(user_group_id: id)
      else
        all
      end
    end

    def approved
      joins(user_group: :users).where(users:{approved:true}).uniq
    end

    def per_day events
      events.to_a.group_by { |event| event.happens_at }
    end
  end

  def self.page(page, per_page)
    if page >= 0
      upcoming.offset page * per_page
    else
      finished.offset((-page-1) * per_page)
    end.limit(per_page)
  end
end
