require "test_helper"

describe User do
  before do
    @user1 = users(:user1)
  end

  it "can be instantiated" do
    expect(@user1.valid?).must_equal true
  end

 # validates :username, presence: true, uniqueness: true

  describe 'validations' do
    before do
      # Arrange
      @user2 = users(:user2)
    end

    it 'is valid when all fields are present' do
      # Act
      result = @user2.valid?

      # Assert
      expect(result).must_equal true
    end

    it 'is invalid without a username' do
      # Arrange
      @user2.username = nil
    
      # Act
      result = @user2.valid?
    
      # Assert
      expect(result).must_equal false
      expect(@user2.errors.messages).must_include :username
    end

    it 'is invalid with a non-unique username' do
      # Arrange
       dup_user2 = User.create(
        username: 'user2'
        )

      # Act

      # Assert
      expect(dup_user2.valid?).must_equal false
      expect(dup_user2.errors.messages).must_include :username

    end

    it 'is valid if username is the same with different case' do
      # Arrange
      dup_user2 = User.create(
        username: 'User2'
        )

      # Act

      # Assert
      expect(dup_user2.valid?).must_equal true

    end
  end

  describe "relationships" do
    before do
      @user3 = users(:user3)
    end

    it "a user can have many votes" do
      expect(@user3.votes.count).must_equal 2

      @user3.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end 

    end

    it "has works through votes" do
      expect(@user3.works.count).must_equal 2
      @user3.works.each do |work|
        expect(work).must_be_instance_of Work
      end
    end

  end

end
