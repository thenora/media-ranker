class Work < ApplicationRecord
  has_many :votes
  has_many :users, :through => :votes

  validates :category, :title, :creator, :description, presence: true
  validates :title, uniqueness: { case_sensitive: false} 
  validates :publication_year, presence: true, numericality: { only_integer: true }

  # TODO add votes

  # TODO DRY up code by creating method that takes a parameter of (category)

  def self.sort_movies
     movies = Work.where(category: "movie").sort_by { |movie| movie.votes.count }
     return movies.reverse
  end
  
  def self.sort_books
    books = Work.where(category: "book").sort_by { |book| book.votes.count }
    return books.reverse
  end

  def self.sort_albums
    albums = Work.where(category: "album").sort_by { |album| album.votes.count }
    return albums.reverse
  end


  def self.spotlight
    @works = Work.all.sort_by { |work| work.votes.count }
    return @works.reverse[0]
  end

end
