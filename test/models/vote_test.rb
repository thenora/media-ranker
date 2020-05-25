require "test_helper"

describe Vote do
  before do
    @vote1 = votes(:vote1)
    @vote2 = votes(:vote2)
    @vote3 = votes(:vote3)
    @vote4 = votes(:vote4)
    @vote5 = votes(:vote5)
    @vote6 = votes(:vote6)
  end

  it "can be instantiated" do
    expect(@vote1.valid?).must_equal true
  end
  
  describe 'validations' do

    it 'is valid when all fields are present' do
      # Act
      result = @vote2.valid?

      # Assert
      expect(result).must_equal true
    end

    it 'is invalid without a user_id' do
      # Arrange
      @vote2.user_id = nil
    
      # Act
      result = @vote2.valid?
    
      # Assert
      expect(result).must_equal false
      expect(@vote2.errors.messages).must_include :user_id
    end


    it 'is invalid without a work_id' do
      # Arrange
      @vote2.work_id = nil
    
      # Act
      result = @vote2.valid?
    
      # Assert
      expect(result).must_equal false
      expect(@vote2.errors.messages).must_include :work_id
    end

    it 'is invalid if user has already voted for that work' do
      # Arrange
      @user1 = users(:user1)
      @movie1 = works(:movie1)

      # Act

      dup_vote = Vote.create(
        user_id: @user1.id,
        work_id: @movie1.id
      )

      # Assert
      expect(dup_vote.valid?).must_equal false
      expect(dup_vote.errors.messages).must_include :user
      expect(dup_vote.errors.messages[:user]).must_equal ["You already voted for this work"]

    end
  end
end
