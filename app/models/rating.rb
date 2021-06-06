class Rating < ApplicationRecord
    belongs_to :movie
    belongs_to :user

    def self.get_max_id
        self.select("MAX(id) as max_id").first.max_id
    end
end
