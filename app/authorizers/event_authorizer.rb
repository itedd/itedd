class EventAuthorizer < ApplicationAuthorizer

  def self.creatable_by?(user)
    user.is_a? Organizer
  end

  def updatable_by?(user)
    user.is_a? Organizer
  end

end
