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

    # TODO Add more is invalid without validation tests
    # TODO add publication date must be number

    # TODO fix unique title test
    it 'is invalid with a non-unique title' do
      # Arrange
       dup_book = Work.create(
        title: 'book1', 
        category: 'book',
        creator: 'Me',
        description: 'Blah blah stuff n things.',
        publication_year: 2011
        )

        # unique_book.save

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
