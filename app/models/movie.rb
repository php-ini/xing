class Movie < ApplicationRecord
    has_many :rating, foreign_key: "movie_id", class_name: "Rating"
    RATING_COUNT_THRESHOLD = 20

    class << self
        def get_movies(max_records = 100, age = '', genre =  '')
            result = self.select(base_select)

            if !age.empty?
                result = age_query(result,age)
            else
                result = result.joins(:rating)
            end

            if !genre.empty?
                result = genre_query(result,genre)
            end

            result = result.group("movie_id")
            .having("rating_count > ?", RATING_COUNT_THRESHOLD)
            .order("average_rate DESC, rating_count DESC")
            .limit(max_records)
        end

        def base_select
            "title, genres, COUNT(rating) AS rating_count, CASE WHEN (FLOOR(COUNT(rating)/100) * 100) < 100 THEN COUNT(rating) ELSE (FLOOR(COUNT(rating)/100) * 100) END AS rating_count_round, ROUND(AVG(rating), 2) AS average_rate"
        end

        def age_query(result, age)
            result.joins("INNER JOIN ratings ON ratings.movie_id = movies.id
                      INNER JOIN users ON ratings.user_id = users.id")
            .where("users.age_id = ?", age)
        end

       def genre_query(result, genre)
            result.where("movies.genres like ?", "%#{genre}%")
       end
   end
end
