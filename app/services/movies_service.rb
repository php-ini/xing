module Services
    class MoviesService
      attr_reader :max_records,:age,:genre
      MOVIES_KEY = 'MOVIES_'
      LAST_RATING_KEY = 'LAST_RATING_KEY'

      def initialize(max_records, age, genre)
        @max_records = max_records
        @age = age
        @genre = genre
      end

      def has_key
        Rails.cache.exist?(self.key)
      end

      # this function is responsible for caching / fetching the results
      def get_movies
        unless has_key
          do_cache
        else
          Rails.cache.read(self.key)
        end
      end

      def do_cache
        Rails.cache.fetch(self.key, :expires_in => 24.hours) do
          #Rails.cache.write(LAST_RATING_KEY, Rating.get_max_id)
          Movie.get_movies(max_records, age, genre)
        end
      end

      def self.key
        MOVIES_KEY + max_records.to_s + '_' + age.to_s + '_' + genre.to_s
      end
        # in case of a new rate inserted
      def has_new_rating
        last_id = Rating.get_max_id
        cached_last_id = Rails.cache.read(LAST_RATING_KEY)

        last_id != cached_last_id
      end

    end
end