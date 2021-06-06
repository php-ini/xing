class MovieController < ApplicationController
    MAX_RECORDS = 100
    GENRES = ['Action', 'Adventure', 'Animation', 'Children\'s', 'Comedy', 'Crime', 'Documentary', 'Drama', 'Fantasy', 'Film-Noir', 'Horror', 'Musical', 'Mystery', 'Romance', 'Sci-Fi', 'Thriller', 'War', 'Western'
]
    # GET method to get all products from database
      def index
        @movies = Movie.get_movies(MAX_RECORDS)
        @increment = 0
        @ages = Age.all
        @genres = GENRES
      end

      def chart
        @ageParam = params[:age]
        @genreParam = params[:genre]
        #Rails.logger.debug("My object: #{@genreParam.inspect}")
        @test = Rating.get_max_id

        @movies = Movie.get_movies(MAX_RECORDS, @ageParam, @genreParam)
        @increment = 0
        @ages = Age.all
        @genres = GENRES
      end
end
