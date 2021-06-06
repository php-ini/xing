class User < ApplicationRecord
    has_many :rating, foreign_key: "user_id", class_name: "Rating"
end
