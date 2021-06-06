class MovieController < ApplicationController
    MAX_RECORDS = 100
    GENRES = ['Action', 'Adventure', 'Animation', 'Children\'s', 'Comedy', 'Crime', 'Documentary', 'Drama', 'Fantasy', 'Film-Noir', 'Horror', 'Musical', 'Mystery', 'Romance', 'Sci-Fi', 'Thriller', 'War', 'Western']
      # GET method to get the first 100 movies from database
      def index
        @movies = Movie.get_movies(MAX_RECORDS)
        @increment = 0
        @ages = Age.all
        @genres = GENRES
      end

      def chart
        @ageParam = params[:age]
        @genreParam = params[:genre]

        @movies = Services::MoviesService.new(MAX_RECORDS, @ageParam, @genreParam).get_movies
        @increment = 0
        @ages = Age.all
        @genres = GENRES
      end
end
