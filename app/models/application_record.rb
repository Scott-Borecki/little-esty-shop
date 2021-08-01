class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def formatted_time
    created_at.to_formatted_s(:long)[0..-6].strip
  end
end
