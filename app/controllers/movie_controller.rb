class MovieController < ApplicationController
    MAX_RECORDS = 100

    # GET method to get all products from database
      def index
        @movies = Movie.get_movies(MAX_RECORDS)
      end
end
