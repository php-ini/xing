class Movie < ApplicationRecord
    has_many :rating, foreign_key: "movie_id", class_name: "Rating"
    RATING_COUNT_THRESHOLD = 20

    class << self
        def get_movies(max_records = 100, age = '', genre =  '')
            result = self.select("title, genres, (FLOOR(COUNT(rating)/100) * 100) AS rating_count, ROUND(AVG(rating), 2) AS average_rate")

            result = result.joins(:rating)

            result = result.group("movie_id")
            .having("rating_count > ?", RATING_COUNT_THRESHOLD)
            .order("average_rate DESC, rating_count DESC")
            .limit(max_records)
        end

   end
end
