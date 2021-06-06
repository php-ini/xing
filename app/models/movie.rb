class Movie < ApplicationRecord
    has_many :rating, foreign_key: "movie_id", class_name: "Rating"
    RATING_COUNT_THRESHOLD = 20
    class << self
        def get_movies(max_records = 100, age = '', genre =  '')
            result = self.select("title, genres, count(rating) as rating_count, round(avg(rating), 2) as average_rate")

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

        def age_query(result, age)
        result.joins("INNER JOIN ratings on ratings.movie_id = movies.id
                                            INNER JOIN users on ratings.user_id = users.id")
                             .where("users.age_id = ?", age)
        end

       def genre_query(result, genre)
            result.where("movies.genres like ?", "%#{genre}%")
       end
   end
end
