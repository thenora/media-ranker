class Work < ApplicationRecord
  # TODO add has many
  # TODO add validations

  # TODO add votes

  # TODO DRY up code by creating method that takes a parameter of (category)

  def self.sort_movies
    return Work.where(category: "movie")
  end
  
  def self.sort_books
    return Work.where(category: "book")
  end

  def self.sort_albums
    return Work.where(category: "album")
  end


  # TODO DRY up code by creating method that takes a parameter of (category)

  def self.top_movies
    movies = self.sort_movies
    return movies.limit(10)
  end

  def self.top_books
    books = self.sort_books
    return books.limit(10)
  end

  def self.top_albums
    albums = self.sort_albums
    return albums.limit(10)
  end

  def self.spotlight
    @works = Work.all
    return @works.sample
  end

  # TODO Base spotlight on votes

end
