class Movie < ApplicationRecord
    has_many :rating, foreign_key: "movie_id", class_name: "Rating"
    RATING_COUNT_THRESHOLD = 20

    class << self
        def get_movies(max_records = 100, age = '', genre =  '')
            result = self.select("title, genres, (FLOOR(COUNT(rating)/100) * 100) AS rating_count, ROUND(AVG(rating), 2) AS average_rate")

            if !age.empty?
                result = age_query(result,age)
            else
                result = result.joins(:rating)
            end

            result = result.group("movie_id")
            .having("rating_count > ?", RATING_COUNT_THRESHOLD)
            .order("average_rate DESC, rating_count DESC")
            .limit(max_records)
        end

        def age_query(result, age)
            result.joins("INNER JOIN ratings ON ratings.movie_id = movies.id
                      INNER JOIN users ON ratings.user_id = users.id")
            .where("users.age_id = ?", age)
        end
   end
end
