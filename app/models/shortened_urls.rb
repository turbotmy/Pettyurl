class Shortened_urls < ActiveRecord::Base
    has_many :stats, dependent: :destroy
    accepts_nested_attributes_for :stats, allow_destroy: true, reject_if: :all_blank
      
end
