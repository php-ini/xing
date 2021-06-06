class Movie < ApplicationRecord
    has_many :rating, foreign_key: "movie_id", class_name: "Rating"
    RATING_COUNT_THRESHOLD = 20
    Rating_ORDER = 20

    def self.get_movies(max_records = 100)
        Movie.select("title, genres, count(rating) as rating_count, round(avg(rating), 2) as average_rate")
        .joins(:rating)
        .group("movie_id")
        .having("rating_count > ?", RATING_COUNT_THRESHOLD)
        .order("average_rate DESC, rating_count DESC")
        .limit(max_records)
    end
end
