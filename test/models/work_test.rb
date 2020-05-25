require "test_helper"

describe Work do
  before do
    @album1 = works(:album1)
    @movie1 = works(:movie1)
    @movie2 = works(:movie2)
    @movie3 = works(:movie3)
    @book1 = works(:book1)
  end

  it "can be instantiated" do
    expect(@album1.valid?).must_equal true
  end

  describe "validations" do

    it "is valid when all fields are present" do
      # Act
      result = @book1.valid?

      # Assert
      expect(result).must_equal true
    end

    it "is invalid without a title" do
      # Arrange
      @movie1.title = nil
    
      # Act
      result = @movie1.valid?
    
      # Assert
      expect(result).must_equal false
      expect(@movie1.errors.messages).must_include :title
    end

    it "is invalid without a category" do
      # Arrange
      @movie1.category = nil
    
      # Act
      result = @movie1.valid?
    
      # Assert
      expect(result).must_equal false
      expect(@movie1.errors.messages).must_include :category
    end

    it "is invalid without a creator" do
      # Arrange
      @movie1.creator = nil
    
      # Act
      result = @movie1.valid?
    
      # Assert
      expect(result).must_equal false
      expect(@movie1.errors.messages).must_include :creator
    end

    it "is invalid without a description" do
      # Arrange
      @movie1.description = nil
    
      # Act
      result = @movie1.valid?
    
      # Assert
      expect(result).must_equal false
      expect(@movie1.errors.messages).must_include :description
    end

    it "is invalid without a publication_year" do
      # Arrange
      @movie1.publication_year = nil
    
      # Act
      result = @movie1.valid?
    
      # Assert
      expect(result).must_equal false
      expect(@movie1.errors.messages).must_include :publication_year
    end

    it "is invalid if publication year is not a number" do
      # Arrange
      @movie2.publication_year = 'Tuesday'
    
      # Act
      result = @movie2.valid?
    
      # Assert
      expect(result).must_equal false
      expect(@movie2.errors.messages).must_include :publication_year
    end

    it 'is invalid with a non-unique title' do
      # Arrange
       dup_book = Work.create(
        title: 'book1', 
        category: 'book',
        creator: 'Me',
        description: 'Blah blah stuff n things.',
        publication_year: 2011
        )

      # Act

      # Assert
      expect(dup_book.valid?).must_equal false
      expect(dup_book.errors.messages).must_include :title

    end

    it 'is invalid if title is the same with different case' do
      # Arrange
       @dup_movie_case = Work.create(
        title: 'MoVie3', 
        category: 'movie',
        creator: 'Myself',
        description: 'Blah blah stuff n things.',
        publication_year: 2013
        )

      # Act

      # Assert
      expect(@dup_movie_case.valid?).must_equal false
      expect(@dup_movie_case.errors.messages).must_include :title

    end
  end

  describe "relationships" do

    it "a work can have many votes" do
      expect(@movie1.votes.count).must_equal 3

      @movie1.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end 

    end

    it "has users through votes" do

      expect(@movie1.users.count).must_equal 3

      @movie1.users.each do |user|
        expect(user).must_be_instance_of User
      end

    end
  end

    # For top-10 or spotlight, what if there are less than 10 works? What if there are no works?

  describe 'sort works' do

    it "sort_books returns books" do
      expect(Work.sort_books).must_include @book1
    end

    it "sort_movies returns movies" do
      expect(Work.sort_movies).must_include @movie1
    end

    it "sort_albums returns albums" do
      expect(Work.sort_albums).must_include @album1
    end
  end

  describe 'spotlight' do

    it "of works are present, returns one work" do
      @spotlight = Work.spotlight
      
      expect(@spotlight).must_be_instance_of Work
    end

    it "returns the work with the most votes" do
      expect(Work.spotlight).must_equal @movie1
    end

  end
end
