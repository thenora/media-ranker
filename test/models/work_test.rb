require "test_helper"

describe Work do
  before do
    @album1 = works(:album1)
  end

  it "can be instantiated" do
    expect(@album1.valid?).must_equal true
  end

  describe 'validations' do
    before do
      # Arrange
      @movie1 = works(:movie1)
      @movie2 = works(:movie2)
      @movie3 = works(:movie3)
      @book1 = works(:book1)
    end

    it 'is valid when all fields are present' do
      # Act
      result = @book1.valid?

      # Assert
      expect(result).must_equal true
    end

    it 'is invalid without a title' do
      # Arrange
      @movie1.title = nil
    
      # Act
      result = @movie1.valid?
    
      # Assert
      expect(result).must_equal false
      expect(@movie1.errors.messages).must_include :title
    end

    it 'is invalid without a category' do
      # Arrange
      @movie1.category = nil
    
      # Act
      result = @movie1.valid?
    
      # Assert
      expect(result).must_equal false
      expect(@movie1.errors.messages).must_include :category
    end

    it 'is invalid without a creator' do
      # Arrange
      @movie1.creator = nil
    
      # Act
      result = @movie1.valid?
    
      # Assert
      expect(result).must_equal false
      expect(@movie1.errors.messages).must_include :creator
    end

    it 'is invalid without a description' do
      # Arrange
      @movie1.description = nil
    
      # Act
      result = @movie1.valid?
    
      # Assert
      expect(result).must_equal false
      expect(@movie1.errors.messages).must_include :description
    end

    it 'is invalid without a publication_year' do
      # Arrange
      @movie1.publication_year = nil
    
      # Act
      result = @movie1.valid?
    
      # Assert
      expect(result).must_equal false
      expect(@movie1.errors.messages).must_include :publication_year
    end

    it 'is invalid if publication year is not a number' do
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
       @dup_book = Work.create(
        title: 'book1', 
        category: 'book',
        creator: 'Me',
        description: 'Blah blah stuff n things.',
        publication_year: 2011
        )

      # Act

      # Assert
      expect(@dup_book.valid?).must_equal false
      expect(@dup_book.errors.messages).must_include :title

    end
  end

  # TODO Test custom methods
    # For top-10 or spotlight, what if there are less than 10 works? What if there are no works?

  # describe 'relations' do
  #   it "has an author" do
  #     book = books(:poodr)
  #     expect(book.author).must_equal authors(:metz)
  #   end

  #   it "can set the author" do
  #     book = Book.new(title: "test book")
  #     book.author = authors(:metz)
  #     expect(book.author_id).must_equal authors(:metz).id
  #   end
  # end

end
