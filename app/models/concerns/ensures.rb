module Ensures
  extend ActiveSupport::Concern

  included do
    before_update :check_link

    class_attribute :ensured_links
  end

  def check_link
    self.ensured_links.each do |link|
      old = self.send(link)
      if old && !old.start_with?('http://') && !old.start_with?('https://')
        self.send(:"#{link}=", "http://#{old}")
      end
    end
  end

end

module ClassMethods
  def ensure_link(fields)
    fields = [fields] unless fields.is_a? Array
    self.ensured_links = fields
  end
end